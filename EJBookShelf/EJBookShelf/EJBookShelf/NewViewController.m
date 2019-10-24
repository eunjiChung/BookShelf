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
#import "EJNewBooks.h"
#import <AFNetworking.h>

@interface NewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger *total;
@property (assign, nonatomic) NSArray *list;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookTableViewCell"];
    
    [self callNewBookList];
}

// MARK: - Request Method
- (void)callNewBookList {
    [[EJHTTPClient sharedInstance] requestNewBookStore:^(id  _Nonnull result) {
        NSDictionary *dict = result;
        EJNewBooks *newBookList = [EJNewBooks modelObjectWithDictionary:dict];
        
        if ([newBookList.error isEqualToString:@"0"]) {
            self.total = newBookList.total;
            self.list = newBookList.books;
        } else {
            self.total = 1;
        }
        
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

// MARK: - TableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.total;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell" forIndexPath:indexPath];
    
    NSLog(@"Book List: %@", self.list);
    
//    if(self.bookList != nil) {
//        EJInfoBook *oneBook = self.bookList[indexPath.row];
//        cell.book = oneBook;
//        NSString *bookTitle = oneBook.title;
//        NSLog(@"Title : %@", bookTitle);
//    }
    
    return cell;
}

// MARK: - TableView Delegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual:@"new_detail_segue"]) {
        DetailViewController *destination = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = sender;
        
        // TODO: - Send book info of specific cell
        NSLog(@"Send book info %@ in %zd", destination, selectedIndexPath.row);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"new_detail_segue" sender:indexPath];
}


@end
