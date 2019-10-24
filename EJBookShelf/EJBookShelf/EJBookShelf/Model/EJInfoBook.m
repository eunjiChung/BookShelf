//
//  EJInfoBook.m
//  EJBookShelf
//
//  Created by eunji on 24/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "EJInfoBook.h"


NSString *const kInfoBookTitle = @"title";
NSString *const kInfoBookSubtitle = @"subtitle";
NSString *const kInfoBookIsbn13 = @"isbn13";
NSString *const kInfoBookPrice = @"price";
NSString *const kInfoBookImage = @"image";
NSString *const kInfoBookUrl = @"url";

@interface EJInfoBook ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EJInfoBook


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.title = [self objectOrNilForKey:kInfoBookTitle fromDictionary:dict];
        self.subtitle = [self objectOrNilForKey:kInfoBookSubtitle fromDictionary:dict];
        self.isbn13 = [self objectOrNilForKey:kInfoBookIsbn13 fromDictionary:dict];
        self.price = [self objectOrNilForKey:kInfoBookPrice fromDictionary:dict];
        self.image = [self objectOrNilForKey:kInfoBookImage fromDictionary:dict];
        self.url = [self objectOrNilForKey:kInfoBookUrl fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kInfoBookTitle];
    [mutableDict setValue:self.subtitle forKey:kInfoBookSubtitle];
    [mutableDict setValue:self.isbn13 forKey:kInfoBookIsbn13];
    [mutableDict setValue:self.price forKey:kInfoBookPrice];
    [mutableDict setValue:self.image forKey:kInfoBookImage];
    [mutableDict setValue:self.url forKey:kInfoBookUrl];

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

    self.title = [aDecoder decodeObjectForKey:kInfoBookTitle];
    self.subtitle = [aDecoder decodeObjectForKey:kInfoBookSubtitle];
    self.isbn13 = [aDecoder decodeObjectForKey:kInfoBookIsbn13];
    self.price = [aDecoder decodeObjectForKey:kInfoBookPrice];
    self.image = [aDecoder decodeObjectForKey:kInfoBookImage];
    self.url = [aDecoder decodeObjectForKey:kInfoBookUrl];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:kInfoBookTitle];
    [aCoder encodeObject:_subtitle forKey:kInfoBookSubtitle];
    [aCoder encodeObject:_isbn13 forKey:kInfoBookIsbn13];
    [aCoder encodeObject:_price forKey:kInfoBookPrice];
    [aCoder encodeObject:_image forKey:kInfoBookImage];
    [aCoder encodeObject:_url forKey:kInfoBookUrl];
}

- (id)copyWithZone:(NSZone *)zone
{
    EJInfoBook *copy = [[EJInfoBook alloc] init];
    
    if (copy) {
        
        copy.title = [self.title copyWithZone:zone];
        copy.subtitle = [self.subtitle copyWithZone:zone];
        copy.isbn13 = [self.isbn13 copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
    }
    
    return copy;
}


@end
