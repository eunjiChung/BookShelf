//
//  NewBooks.m
//  EJBookShelf
//
//  Created by CHUNGEUNJI on 28/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "NewBooks.h"
#import "BookModel.h"

@implementation NewBooks

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
     self = [super init];
    
     if (self) {
         self.error = [dictionary objectForKey:@"error"];
         self.total = [[dictionary objectForKey:@"total"] integerValue];
         
         NSMutableArray *array = (NSMutableArray *) [dictionary objectForKey:@"books"];
         self.books = [[NSMutableArray alloc] init];
         
         for (NSDictionary *temp in array) {
             BookModel *book = [[BookModel alloc] initWithDictionary: temp];
             [self.books addObject:book];
         }
     }

     return self;
}

@end
