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

@interface NewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNib];
}

// MARK: - TableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell" forIndexPath:indexPath];
    return cell;
}

// MARK: - TableView Delegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual:@"new_detail_segue"]) {
        DetailViewController *destination = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = sender;
        NSLog(@"Send book info %@ in %zd", destination, selectedIndexPath.row);
        [self performSegueWithIdentifier:@"new_detail_segue" sender:selectedIndexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self prepareForSegue:@"new_detail_segue" sender:indexPath];
}

// MARK: - Layout Method
- (void)registerNib {
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookTableViewCell"];
}

@end
