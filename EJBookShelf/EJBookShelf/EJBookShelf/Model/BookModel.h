//
//  TestModel.h
//  EJBookShelf
//
//  Created by CHUNGEUNJI on 25/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces
@interface BookModel : NSObject

@property (nonatomic, copy) NSString *error;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *authors;
@property (nonatomic, copy) NSString *publisher;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *isbn10;
@property (nonatomic, copy) NSString *isbn13;
@property (nonatomic, copy) NSString *pages;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

