//
//  EJHTTPClient.m
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "EJHTTPClient.h"
#import <AFNetworking/AFNetworking.h>

NSString *bookStoreNewURL = @"https://api.itbook.store/1.0/new";
NSString *bookStoreSearchURL = @"https://api.itbook.store/1.0/search/";
NSString *bookDetailURL = @"https://api.itbook.store/1.0/books/";

@implementation EJHTTPClient

- (void)requestNewBookStore:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure
{
    NSURL *URL = [NSURL URLWithString:bookStoreNewURL];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        failure(error);
    }];
    
}

- (void)requestSearchBookStore:(NSString *)keyword
                       success:(void (^)(id result))success
                       failure:(void (^)(NSError *error))failure {
    NSString *bookSearchURL = [bookStoreSearchURL stringByAppendingString:@"mongoDB"];
    NSURL *URL = [NSURL URLWithString:bookSearchURL];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        failure(error);
    }];
}

- (void)requestDetailBookInfo:(NSString *)isbnCode
                      success:(void (^)(id result))success
                      failure:(void (^)(NSError *error))failure
{
    NSString *isbnUrl = [bookStoreSearchURL stringByAppendingString:@"9781484206485"];
    NSURL *URL = [NSURL URLWithString:isbnUrl];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        failure(error);
    }];
}

@end