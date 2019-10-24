//
//  EJNewBooks.m
//  EJBookShelf
//
//  Created by eunji on 24/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "EJNewBooks.h"
#import "EJInfoBook.h"

NSString *const kNewBooksError = @"error";
NSString *const kNewBooksTotal = @"total";
NSString *const kNewBooksBooks = @"books";

@interface EJNewBooks ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EJNewBooks


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.error = [self objectOrNilForKey:kNewBooksError fromDictionary:dict];
        self.total = [[self objectOrNilForKey:kNewBooksTotal fromDictionary:dict] integerValue];
        
        NSObject *receivedBooks = [dict objectForKey:kNewBooksBooks];
        NSMutableArray *parsedEJInfoBook = [NSMutableArray array];
        if ([receivedBooks isKindOfClass:[NSArray class]])
        {
            for (NSDictionary *item in (NSArray *)receivedBooks) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedEJInfoBook addObject:[EJInfoBook modelObjectWithDictionary: item]];
                }
            }
        } else if ([receivedBooks isKindOfClass:[NSDictionary class]])
        {
            [parsedEJInfoBook addObject:[EJInfoBook modelObjectWithDictionary:(NSDictionary *)receivedBooks]];
        }
        self.books = [NSArray arrayWithArray:parsedEJInfoBook];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.error forKey:kNewBooksError];
    [mutableDict setValue:[NSNumber numberWithInteger:self.total] forKey:kNewBooksTotal];
    
    NSMutableArray *tempArrayForNewBooks = [NSMutableArray array];
    for (NSObject *subArrayObject in self.books) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNewBooks addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNewBooks addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNewBooks] forKey:kNewBooksBooks];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.error = [aDecoder decodeObjectForKey:kNewBooksError];
    self.total = [aDecoder decodeIntegerForKey:kNewBooksTotal];
    self.books = [aDecoder decodeObjectForKey:kNewBooksBooks];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_error forKey:kNewBooksError];
    [aCoder encodeInteger:_total forKey:kNewBooksTotal];
    [aCoder encodeObject:_books forKey:kNewBooksBooks];
}

- (id)copyWithZone:(NSZone *)zone
{
    EJNewBooks *copy = [[EJNewBooks alloc] init];
    
    if (copy) {
        
        copy.error = [self.error copyWithZone:zone];
        copy.total = self.total;
        copy.books = [self.books copyWithZone:zone];
    }
    
    return copy;
}




@end
