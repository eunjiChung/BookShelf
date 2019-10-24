//
//  EJHTTPClient.h
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewBooks;

NS_ASSUME_NONNULL_BEGIN

@interface EJHTTPClient : NSObject

+ (instancetype)sharedInstance;

- (void)requestNewBookStore:(void (^)(id result))success
                    failure:(void (^)(NSError *error))failure;
- (void)requestSearchBookStore:(NSString *)keyword
                       success:(void (^)(id result))success
                       failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
