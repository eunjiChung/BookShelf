//
//  NewBooks.h
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewBooks;
@class Book;

NS_ASSUME_NONNULL_BEGIN

@interface NewBooks : NSObject

@property (nonatomic, copy) NSString *error;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSArray<Book *> *books;

@end

NS_ASSUME_NONNULL_END
