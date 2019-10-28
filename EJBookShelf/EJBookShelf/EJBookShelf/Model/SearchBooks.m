//
//  SearchBooks.m
//  EJBookShelf
//
//  Created by CHUNGEUNJI on 28/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "SearchBooks.h"
#import "BookModel.h"

@implementation SearchBooks

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
     self = [super init];
    
     if (self) {
         self.error = [dictionary objectForKey:@"error"];
         self.total = [[dictionary objectForKey:@"total"] integerValue];
         self.page = [[dictionary objectForKey:@"page"] integerValue];
         
         NSMutableArray *array = (NSMutableArray *) [dictionary objectForKey:@"books"];
         self.books = [[NSMutableArray alloc] init];
         
         for (NSDictionary *temp in array) {
             BookModel *book = [[BookModel alloc] initWithDictionary: temp];
             [self.books addObject:book];
         }
     }

     return self;
}

- (instancetype)addLoadedBooks:(NSDictionary *)dictionary {
    if (![self.error isEqualToString:dictionary[@"error"]]) { self.error = dictionary[@"error"]; }
    NSInteger newTotal = [[dictionary objectForKey:@"total"] integerValue];
    if (self.total != newTotal) { self.total = newTotal; }
    NSInteger newPage = [[dictionary objectForKey:@"page"] integerValue];
    if (self.page != newPage) { self.page = newPage; }
    NSLog(@"New Page: %zd", self.page);
    
    NSMutableArray *array = [dictionary objectForKey:@"books"];
    
    NSLog(@"Original Books: %@", self.books);
    NSMutableArray<BookModel *> *newBooks = [[NSMutableArray alloc] init];
    
    for (NSDictionary *temp in array) {
        BookModel *book = [[BookModel alloc] initWithDictionary:temp];
        [newBooks addObject:book];
        NSLog(@"New books: %@", newBooks);
    }
    
    [self.books addObjectsFromArray:newBooks];
    NSLog(@"After Array: %@", self.books);
    
    return self;
}

@end
