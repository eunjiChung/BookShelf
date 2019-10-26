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

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *list; // 가져오는 책 결과 리스트
@property (assign, nonatomic) NSInteger total;      // 총 페이지 수
@property (assign, nonatomic) NSInteger page;       // 현재 몇 쪽인지
@property (assign, nonatomic) NSString *keyword;    // 검색 키워드

@end

@implementation SearchViewController


#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize
    [self registerNibForClass];
    
    self.total = 1;
    self.page = 1;
    
    [self addPullToRefreshControl];
    [self addInfiniteScrollingControl];
}


#pragma mark - Call API

- (void)callBySearchKeyword:(NSString *)keyword {
    [[EJHTTPClient sharedInstance] requestSearchBookStore:keyword page:self.page success:^(id  _Nonnull result) {
        NSDictionary *dict = (NSDictionary *)result;
        self.total = [dict[@"total"] integerValue];
        
        NSMutableArray *array = (NSMutableArray *) dict[@"books"];
        if (self.list == nil) {
            self.list = [array mutableCopy];
        } else {
            [self.list addObjectsFromArray:array];
        }
        
        self.page = [dict[@"page"] integerValue];
        
        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
        [self.tableView.infiniteScrollingView stopAnimating];
    } failure:^(NSError * _Nonnull error) {
        [self showErrorAlert:error];
    }];
}

#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    
    if (![searchBar.text isEqualToString:@""]) {
        NSString *notEncoded = searchBar.text;
        NSString *encoded = [notEncoded stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.keyword = encoded;
        [self callBySearchKeyword:self.keyword];
    } else {
        [self showDefaultAlert:@"알림" message:@"검색어를 넣어주세요"];
    }
}



#pragma mark - TableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.total == 0) {
        return 1;
    }
    return (self.list == nil) ? 1 : self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.list == nil) {
        ResultInfoTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"ResultInfoTableViewCell" forIndexPath:indexPath];
        cell2.resultLabel.text = [NSString stringWithFormat:@"검색어를 넣어주세요!"];
        return cell2;
    } else {
        // 검색 결과가 없는 경우
        if (self.total == 0) {
            ResultInfoTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"ResultInfoTableViewCell" forIndexPath:indexPath];
            cell2.resultLabel.text = [NSString stringWithFormat:@"검색 결과가 없습니다!"];
            return cell2;
        }
        
        // 검색 결과가 있는 경우
        // 첫번째 셀에는 몇개의 결과가 검색됐는지 표시
        if (indexPath.row == 0) {
            ResultInfoTableViewCell *cell2 = (ResultInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"ResultInfoTableViewCell" forIndexPath:indexPath];
            cell2.resultLabel.text = [NSString stringWithFormat:@"총 %zd개의 결과가 검색됐습니다.", self.total];
            return cell2;
        } else {
            // 결과를 나타냄
            BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell" forIndexPath:indexPath];
            
            NSDictionary *bookInfo = self.list[indexPath.row];
            [cell.bookImageView setImageWithURL:[NSURL URLWithString:bookInfo[@"image"]]];
            cell.bookTitleLabel.text = bookInfo[@"title"];
            
            if (![bookInfo[@"subtitle"] isEqual:@""]) {
                cell.bookSubTitleLabel.text = bookInfo[@"subtitle"];
            }
            
            cell.bookPriceLabel.text = bookInfo[@"price"];
            cell.bookIsbnLabel.text = bookInfo[@"isbn13"];
            cell.bookUrlTextView.attributedText = [self generateHyperlink:bookInfo[@"url"]];
            
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
        NSDictionary *book = self.list[selectedIndexPath.row];
        destination.isbn13 = book[@"isbn13"];
    }
}

#pragma mark - Private Method
- (void)addPullToRefreshControl {
    [self.tableView addPullToRefreshWithActionHandler:^{
        self.total = 1;
        self.page = 1;
        self.list = nil;
        [self callBySearchKeyword:self.keyword];
    }];
}

- (void)addInfiniteScrollingControl {
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        self.page += 1;
        
        if ([self isEndOfPage]) {
            [self.tableView.infiniteScrollingView stopAnimating];
        } else {
            [self callBySearchKeyword:self.keyword];
        }
    }];
}

- (BOOL)isEndOfPage {
    NSInteger totalPage = (self.total % 10 != 0) ? (self.total / 10 + 1) : (self.total / 10);
    return self.page > totalPage ? YES : NO;
}

- (void)registerNibForClass {
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ResultInfoTableViewCell"];
}


@end
