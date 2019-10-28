//
//  NewBooks.h
//  EJBookShelf
//
//  Created by CHUNGEUNJI on 28/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookModel;

NS_ASSUME_NONNULL_BEGIN

@interface NewBooks : NSObject

@property (nonatomic, copy) NSString *error;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, retain) NSMutableArray<BookModel *> *books;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
