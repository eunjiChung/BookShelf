//
//  EJLibrary.m
//  BookShelf
//
//  Created by CHUNGEUNJI on 22/10/2019.
//  Copyright © 2019 CHUNGEUNJI. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NSString *bookStoreNewURL = @"https://api.itbook.store/1.0/new";
NSString *bookStoreSearchURL = @"https://api.itbook.store/1.0/search/";

@implementation EJLibrary : NSObject

- (void) requestNewBookStore {
    NSURL *URL = [NSURL URLWithString:bookStoreNewURL];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}

- (void) requestSearchBookStore:(NSString *)keyword {
    NSString *bookSearchURL = [bookStoreSearchURL stringByAppendingString:@"mongoDB"];
    NSURL *URL = [NSURL URLWithString:bookSearchURL];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end
