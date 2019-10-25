//
//  TestModel.m
//  EJBookShelf
//
//  Created by CHUNGEUNJI on 25/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "TestModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - JSON serialization

@implementation TestModel

- (TestModel *)initWithDictionary:(NSDictionary *)dictionary {
     self = [super init];
    
     if(self){
         self.error = [dictionary objectForKey:@"error"];
         self.title = [dictionary objectForKey:@"title"];
         self.subtitle = [dictionary objectForKey:@"subtitle"];
         self.authors = [dictionary objectForKey:@"authors"];
         self.publisher = [dictionary objectForKey:@"publisher"];
         self.language = [dictionary objectForKey:@"language"];
         self.isbn10 = [dictionary objectForKey:@"isbn10"];
         self.isbn13 = [dictionary objectForKey:@"isbn13"];
         self.pages = [dictionary objectForKey:@"pages"];
         self.year = [dictionary objectForKey:@"year"];
         self.rating = [dictionary objectForKey:@"rating"];
         self.desc = [dictionary objectForKey:@"desc"];
         self.price = [dictionary objectForKey:@"price"];
         self.image = [dictionary objectForKey:@"image"];
         self.url = [dictionary objectForKey:@"url"];
     }

     return self;
}

@end

NS_ASSUME_NONNULL_END
