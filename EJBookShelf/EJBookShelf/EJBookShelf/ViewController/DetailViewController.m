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

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (assign, nonatomic) NSDictionary *bookInfo;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookTableViewCell"];
    [self callBookInfo];
}

#pragma mark - Call API
- (void)callBookInfo {
    [[EJHTTPClient sharedInstance] requestDetailBookInfo:self.isbn13 success:^(id  _Nonnull result) {
        NSDictionary *dict = result;
        self.bookInfo = dict;
        [self.tableview reloadData];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
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
    switch (indexPath.row) {
        case 0:
            DetailBookImageTableViewCell *cell
            DetailBookImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultInfoTableViewCell" forIndexPath:indexPath];
            return cell;
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            NSLog(@"No Cell");
            break;
    }
    
    return [[UITableViewCell alloc] init];
}

@end
