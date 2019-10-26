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
#import "AddTableViewCell.h"
#import "MemoTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (assign, nonatomic) NSDictionary *bookInfo;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerTableViewCellNibs];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 2;   // TODO: - 메모들 갯수 리턴
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DetailBookImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookImageTableViewCell" forIndexPath:indexPath];
            [cell.bookImageView setImageWithURL:[NSURL URLWithString:self.bookInfo[@"image"]]];
            return cell;
        } else if (indexPath.row == 1) {
            DetailBookInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookInfoTableViewCell" forIndexPath:indexPath];
            
            if (self.bookInfo != nil) {
                cell.bookTitleLabel.text = self.bookInfo[@"title"];
                cell.bookSubtitleLabel.text = self.bookInfo[@"subtitle"];
                cell.bookPriceLabel.text = self.bookInfo[@"price"];
                // TODO: - Rating이 0일 경우는 어떻게...?
                cell.bookRatingLabel.text = [NSString stringWithFormat:@"Rating %@", self.bookInfo[@"rating"]];
                cell.bookAuthorLabel.text = self.bookInfo[@"authors"];
                cell.bookPublisherLabel.text = self.bookInfo[@"publisher"];
                cell.bookYear.text = [NSString stringWithFormat:@"%@Year", self.bookInfo[@"year"]];
                cell.bookPages.text = [NSString stringWithFormat:@"%@pages", self.bookInfo[@"pages"]];
                cell.bookIsbn10Label.text = self.bookInfo[@"isbn10"];
                cell.bookIsbn13Label.text = self.bookInfo[@"isbn13"];
                cell.bookLanguage.text = self.bookInfo[@"language"];
                cell.bookUrl.attributedText = [self generateHyperlink:self.bookInfo[@"url"]];
            }

            return cell;
        } else if (indexPath.row == 2) {
            DetailBookDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookDescTableViewCell" forIndexPath:indexPath];
            cell.descTextLabel.text = self.bookInfo[@"desc"];
            return cell;
        }
    } else {
        if (indexPath.row == 0) {
            MemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemoTableViewCell" forIndexPath:indexPath];
            return cell;
        } else {
            AddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddTableViewCell" forIndexPath:indexPath];
            return cell;
        }
    }
    
    return [[UITableViewCell alloc] init];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"책 메모";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 300.0;
        } else if (indexPath.row == 1) {
            return 280.0;
        }
        return UITableViewAutomaticDimension;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 70.0;
        } else {
            return 50.0;
        }
    }
    
    return 70.0;
}

#pragma mark - Private Method
- (void)registerTableViewCellNibs {
    [self.tableview registerNib:[UINib nibWithNibName:@"AddTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddTableViewCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"MemoTableViewCell" bundle:nil] forCellReuseIdentifier:@"MemoTableViewCell"];
}

@end
