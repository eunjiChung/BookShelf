//
//  EJNewBooks.h
//  EJBookShelf
//
//  Created by eunji on 24/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EJNewBooks : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy)     NSString    *error;
@property (nonatomic, assign)   NSInteger   *total;
@property (nonatomic, copy)     NSArray     *books;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END