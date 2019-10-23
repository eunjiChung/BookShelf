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
#import <AFNetworking.h>

@interface NewViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) EJHTTPClient *httpClient;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookTableViewCell"];
    
    [self callNewBookList];
}

// MARK: - Request Method
- (void)callNewBookList {
    NSLog(@"Calling New Book List");
    
    NSURL *URL = [NSURL URLWithString:@"https://api.itbook.store/1.0/new"];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [sessionManager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewBooks *newBooks = responseObject;
        NSLog(@"%@", newBooks);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
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
        
        // TODO: - Send book info of specific cell
        NSLog(@"Send book info %@ in %zd", destination, selectedIndexPath.row);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"new_detail_segue" sender:indexPath];
}


@end
