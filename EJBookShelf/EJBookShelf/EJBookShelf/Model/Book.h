//
//  Book.h
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *isbn13;
@property (nonatomic, strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
