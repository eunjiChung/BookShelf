//
//  SearchViewController.m
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "SearchViewController.h"
#import "BookTableViewCell.h"
#import "ResultInfoTableViewCell.h"
#import "EJHTTPClient.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import <SVPullToRefresh.h>
#import "SearchBooks.h"
#import "BookModel.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) SearchBooks *searchedBooks;   // 검색한 책 리스트
@property (assign, nonatomic) NSString *keyword;            // 검색 키워드
@property (assign, nonatomic) NSInteger startRows;          // 테이블 뷰가 시작되는 줄

@end

@implementation SearchViewController


#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize
    [self registerNibForClass];
    [self.activityIndicator setHidden:YES];
    
    [self addPullToRefreshControl];
    [self addInfiniteScrollingControl];
}

#pragma mark - Touch Action
// 상단 바를 터치하면 키보드가 내려간다 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

#pragma mark - Call API

- (void)callBySearchKeyword:(NSString *)keyword page:(NSInteger)page {
    if (keyword != nil) {
        [[EJHTTPClient sharedInstance] requestSearchBookStore:keyword
                                                         page:page
                                                      success:^(id  _Nonnull result) {
            NSDictionary *dict = (NSDictionary *)result;
            
            if (self.searchedBooks == nil) {
                self.searchedBooks = [[SearchBooks alloc] initWithDictionary:dict];
                [self.tableView reloadData];
            } else {
                [self insertNewRows:dict];
            }
            
            [self.tableView.pullToRefreshView stopAnimating];
            [self.tableView.infiniteScrollingView stopAnimating];
            [self.activityIndicator stopAnimating];
            [self.activityIndicator setHidden:YES];
        } failure:^(NSError * _Nonnull error) {
            [self showErrorAlert:error];
        }];
    } else {
        [self showDefaultAlert:@"알림!" message:@"검색어를 넣어주세요!"];
        
        [self.tableView.pullToRefreshView stopAnimating];
        [self.tableView.infiniteScrollingView stopAnimating];
        [self.activityIndicator stopAnimating];
        [self.activityIndicator setHidden:YES];
    }
}

#pragma mark - SearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    
    if (![searchBar.text isEqualToString:@""]) {
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
        
        NSString *notEncoded = searchBar.text;
        NSString *encoded = [notEncoded stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.keyword = encoded;
        
        self.searchedBooks = nil;
        [self callBySearchKeyword:self.keyword page:1];
    } else {
        [self showDefaultAlert:@"알림" message:@"검색어를 넣어주세요"];
    }
}



#pragma mark - TableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchedBooks.total == 0) { return 1; }
    return (self.searchedBooks == nil) ? 1 : self.searchedBooks.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        // 검색 전
    if (self.searchedBooks == nil) {
        ResultInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultInfoTableViewCell" forIndexPath:indexPath];
        cell.resultLabel.text = [NSString stringWithFormat:@"검색어를 넣어주세요!"];
        return cell;
    }
    else
    {
        // 검색 후
        
        // 1. 검색 결과가 없는 경우
        if (self.searchedBooks.total == 0) {
            ResultInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultInfoTableViewCell" forIndexPath:indexPath];
            cell.resultLabel.text = [NSString stringWithFormat:@"검색 결과가 없습니다!"];
            return cell;
        }
        
        // 2. 검색 결과가 있는 경우
        if (indexPath.row == 0) {
            // 2-1. 첫번째 셀에는 몇개의 결과가 검색됐는지 표시
            ResultInfoTableViewCell *cell2 = (ResultInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"ResultInfoTableViewCell" forIndexPath:indexPath];
            cell2.resultLabel.text = [NSString stringWithFormat:@"총 %zd개의 결과가 검색됐습니다.", self.searchedBooks.total];
            return cell2;
        } else {
            // 2-2. 결과를 나타냄
            BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell" forIndexPath:indexPath];
            
            BookModel *book = (BookModel *) self.searchedBooks.books[indexPath.row];
            
            [cell.bookImageView setImageWithURL:[NSURL URLWithString:book.image]];
            cell.bookTitleLabel.text = book.title;
            if (![book.subtitle isEqual:@""]) { cell.bookSubTitleLabel.text = book.subtitle; }
            cell.bookPriceLabel.text = book.price;
            cell.bookIsbnLabel.text = book.isbn13;
            cell.bookUrlTextView.attributedText = [self generateHyperlink:book.url];
            
            return cell;
        }
    }
    
    
    return [[UITableViewCell alloc] init];
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"search_detail_segue" sender:indexPath];
}

#pragma mark - Segue Action
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"search_detail_segue"]) {
        DetailViewController *destination = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = sender;
        BookModel *book = self.searchedBooks.books[selectedIndexPath.row];
        destination.isbn13 = book.isbn13;
    }
}

#pragma mark - Private Method
- (void)insertNewRows:(NSDictionary *)newResults {
    NSInteger startRowIndex = self.searchedBooks.books.count;
    NSMutableArray *indexPathList = [NSMutableArray new];
    
    NSMutableArray<BookModel *> *originalBooks = self.searchedBooks.books.mutableCopy;
    SearchBooks *newSearchResults = [[SearchBooks alloc] initWithDictionary:newResults];
    [originalBooks addObjectsFromArray:newSearchResults.books];
    self.searchedBooks.books = originalBooks;
    
    for(int i = 0; i < newSearchResults.books.count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:startRowIndex+i inSection:0];
        [indexPathList addObject:indexPath];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView insertRowsAtIndexPaths:indexPathList withRowAnimation:UITableViewRowAnimationAutomatic];
    });
}

- (void)addPullToRefreshControl {
    [self.tableView addPullToRefreshWithActionHandler:^{
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
        
        self.searchedBooks = nil;
        [self callBySearchKeyword:self.keyword page:1];
    }];
}

- (void)addInfiniteScrollingControl {
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        self.searchedBooks.page += 1;
        
        if ([self isEndOfPage]) {
            [self.tableView.infiniteScrollingView stopAnimating];
        } else {
            [self callBySearchKeyword:self.keyword page:self.searchedBooks.page];
        }
    }];
}

- (BOOL)isEndOfPage {
    NSInteger total = self.searchedBooks.total;
    NSInteger totalPage = (total % 10 != 0) ? (total / 10 + 1) : (total / 10);
    return self.searchedBooks.page > totalPage ? YES : NO;
}

- (void)registerNibForClass {
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ResultInfoTableViewCell"];
}


@end
