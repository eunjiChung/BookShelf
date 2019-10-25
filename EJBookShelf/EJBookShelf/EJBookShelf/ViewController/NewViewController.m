//
//  NewViewController.m
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "NewViewController.h"
#import "BookTableViewCell.h"
#import "DetailViewController.h"
#import "EJHTTPClient.h"
#import "UIImageView+AFNetworking.h"


#import "TestModel.h"

@interface NewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger total;
@property (strong, nonatomic) NSMutableArray *list;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookTableViewCell"];
    
    self.list = [[NSMutableArray alloc] init];
    [self callNewBookList];
}

#pragma mark - Request Method
- (void)callNewBookList {
    
    [[EJHTTPClient sharedInstance] requestNewBookStore:^(id  _Nonnull result) {
        NSDictionary *dict = (NSDictionary *) result;
        self.total = [dict[@"total"] integerValue];
        NSMutableArray *array = (NSMutableArray *) dict[@"books"];
        self.list = [array mutableCopy];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"Error : %@", error.localizedDescription);
    }];
}

#pragma mark - TableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.total;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell" forIndexPath:indexPath];
    
    if (self.list.count > 0) {
        NSDictionary *bookInfo = self.list[indexPath.row];
        [cell.bookImageView setImageWithURL:[NSURL URLWithString:bookInfo[@"image"]]];
        cell.bookTitleLabel.text = bookInfo[@"title"];
        cell.bookSubTitleLabel.text = bookInfo[@"subtitle"];
        cell.bookPriceLabel.text = bookInfo[@"price"];
        cell.bookIsbnLabel.text = bookInfo[@"isbn13"];
        cell.bookUrlLabel.text = bookInfo[@"url"];
    }
    
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 193.0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual:@"new_detail_segue"]) {
        DetailViewController *destination = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = sender;
        NSDictionary *book = self.list[selectedIndexPath.row];
        destination.isbn13 = book[@"isbn13"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"new_detail_segue" sender:indexPath];
}


@end
