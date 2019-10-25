//
//  DetailViewController.m
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "DetailViewController.h"
#import "BookTableViewCell.h"
#import "EJHTTPClient.h"
#import "DetailBookDescTableViewCell.h"
#import "DetailBookInfoTableViewCell.h"
#import "DetailBookImageTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (assign, nonatomic) NSDictionary *bookInfo;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self callBookInfo];
}

#pragma mark - Call API
- (void)callBookInfo {
    [[EJHTTPClient sharedInstance] requestDetailBookInfo:self.isbn13 success:^(id  _Nonnull result) {
        NSDictionary *dict = result;
        self.bookInfo = dict;
        [self.tableview reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self showErrorAlert:error];
    }];
}

#pragma mark - Button Action
- (IBAction)didTouchCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark  - TableView Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        DetailBookImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookImageTableViewCell" forIndexPath:indexPath];
        [cell.bookImageView setImageWithURL:[NSURL URLWithString:self.bookInfo[@"image"]]];
        return cell;
    } else if (indexPath.row == 1) {
        DetailBookInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookInfoTableViewCell" forIndexPath:indexPath];
        
        cell.bookTitleLabel.text = self.bookInfo[@"title"];
        cell.bookSubtitleLabel.text = self.bookInfo[@"subtitle"];
        cell.bookPriceLabel.text = self.bookInfo[@"price"];
        cell.bookAuthorLabel.text = self.bookInfo[@"authors"];
        cell.bookPublisherLabel.text = self.bookInfo[@"publisher"];
        cell.bookYear.text = self.bookInfo[@"year"];
        cell.bookPages.text = self.bookInfo[@"pages"];
        cell.bookIsbn10Label.text = self.bookInfo[@"isbn10"];
        cell.bookIsbn13Label.text = self.bookInfo[@"isbn13"];
        cell.bookLanguage.text = self.bookInfo[@"language"];
        
        return cell;
    } else if (indexPath.row == 2) {
        DetailBookDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookDescTableViewCell" forIndexPath:indexPath];
        cell.descTextLabel.text = self.bookInfo[@"desc"];
        return cell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 300.0;
    }
    return UITableViewAutomaticDimension;
}

@end
