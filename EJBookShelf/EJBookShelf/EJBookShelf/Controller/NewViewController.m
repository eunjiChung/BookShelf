//
//  NewViewController.m
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "NewViewController.h"
#import "BookTableViewCell.h"
#import "EJHTTPClient.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"
#import "NewBooks.h"
#import "BookModel.h"

@interface NewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NewBooks *booksInfo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookTableViewCell"];

    [self.activityIndicator startAnimating];
    [self callNewBookList];
}

#pragma mark - Request Method
- (void)callNewBookList {
    [[EJHTTPClient sharedInstance] requestNewBookStore:^(id  _Nonnull result) {
        NSDictionary *dict = (NSDictionary *) result;
        self.booksInfo = [[NewBooks alloc] initWithDictionary:dict];
        [self.tableView reloadData];
        
        [self.activityIndicator stopAnimating];
        [self.activityIndicator setHidden:YES];
    } failure:^(NSError * _Nonnull error) {
        [self showErrorAlert:error];
    }];
}

#pragma mark - TableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.booksInfo != nil) { return self.booksInfo.total; }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell" forIndexPath:indexPath];
    
    if (self.booksInfo != nil) {
        BookModel *book = (BookModel *) self.booksInfo.books[indexPath.row];
        [cell.bookImageView setImageWithURL:[NSURL URLWithString:book.image]];
        cell.bookTitleLabel.text = book.title;
        cell.bookSubTitleLabel.text = book.subtitle;
        cell.bookPriceLabel.text = book.price;
        cell.bookIsbnLabel.text = book.isbn13;
        cell.bookUrlTextView.attributedText = [self generateHyperlink:book.url];
    }
    
    return cell;
}


#pragma mark - Segue Action
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual:@"new_detail_segue"]) {
        DetailViewController *destination = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = sender;
        BookModel *book = (BookModel *) self.booksInfo.books[selectedIndexPath.row];
        destination.isbn13 = book.isbn13;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"new_detail_segue" sender:indexPath];
}


@end
