//
//  BookInfo.h
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookInfo;
@class Book;

NS_ASSUME_NONNULL_BEGIN

@interface BookInfo : NSObject

@property (nonatomic, copy) Book *book;
@property (nonatomic, copy) NSString *error;
@property (nonatomic, copy) NSString *authors;
@property (nonatomic, copy) NSString *publisher;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *isbn10;
@property (nonatomic, copy) NSString *pages;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *desc;

@end

NS_ASSUME_NONNULL_END
