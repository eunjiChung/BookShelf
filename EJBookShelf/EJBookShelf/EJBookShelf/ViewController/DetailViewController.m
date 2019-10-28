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
#import "BookModel.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) BookModel *model;

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
        self.model = [[BookModel alloc] initWithDictionary:dict];
        
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
        
        if (self.model != nil) {
            [cell.bookImageView setImageWithURL:[NSURL URLWithString:self.model.image]];
        }
        
        return cell;
    } else if (indexPath.row == 1) {
        DetailBookInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookInfoTableViewCell" forIndexPath:indexPath];
        
        if (self.model != nil) {
            cell.bookTitleLabel.text = self.model.title;
            cell.bookSubtitleLabel.text = self.model.subtitle;
            cell.bookPriceLabel.text = self.model.price;
            cell.bookRatingLabel.text = [NSString stringWithFormat:@"Rating %@", self.model.rating];
            cell.bookAuthorLabel.text = self.model.authors;
            cell.bookPublisherLabel.text = self.model.publisher;
            cell.bookYear.text = [NSString stringWithFormat:@"%@Year", self.model.year];
            cell.bookPages.text = [NSString stringWithFormat:@"%@pages", self.model.pages];
            cell.bookIsbn10Label.text = self.model.isbn10;
            cell.bookIsbn13Label.text = self.model.isbn13;
            cell.bookLanguage.text = self.model.language;
            cell.bookUrl.attributedText = [self generateHyperlink:self.model.url];
        }
        
        
        return cell;
    } else if (indexPath.row == 2) {
        DetailBookDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookDescTableViewCell" forIndexPath:indexPath];
        
        if (self.model != nil) {
            cell.descTextLabel.text = self.model.desc;
        }
        
        return cell;
    }
    
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 300.0;
    } else if (indexPath.row == 1) {
        return 280.0;
    }
    return UITableViewAutomaticDimension;
}

@end
