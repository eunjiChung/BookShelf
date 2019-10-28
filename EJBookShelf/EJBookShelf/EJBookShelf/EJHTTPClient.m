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

// MARK: - Shared Instance
+ (instancetype)sharedInstance
{
    static EJHTTPClient *_sharedInstance = nil;
    static dispatch_once_t oncePredicate; //...
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[EJHTTPClient alloc] init];
    });
    
    return _sharedInstance;
}


// MARK: - API Call
- (void)requestNewBookStore:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure
{
    NSURL *URL = [NSURL URLWithString:bookStoreNewURL];
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *task = [sessionManager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    [task resume];
}

- (void)requestSearchBookStore:(NSString *)keyword
                          page:(NSInteger)page
                       success:(void (^)(id result))success
                       failure:(void (^)(NSError *error))failure {
    NSString *keywordURL = [bookStoreSearchURL stringByAppendingString:keyword];
    NSString *nextSearchURL = [keywordURL stringByAppendingFormat:@"/%zd", page];
    
    NSURL *URL = [NSURL URLWithString:nextSearchURL];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [sessionManager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)requestDetailBookInfo:(NSString *)isbnCode
                      success:(void (^)(id result))success
                      failure:(void (^)(NSError *error))failure
{
    NSString *isbnUrl = [bookDetailURL stringByAppendingString:isbnCode];
    NSURL *URL = [NSURL URLWithString:isbnUrl];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [sessionManager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
