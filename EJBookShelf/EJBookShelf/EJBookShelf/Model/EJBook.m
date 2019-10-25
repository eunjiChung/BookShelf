#import "EJBook.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface EJBook (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

#pragma mark - JSON serialization

EJBook *_Nullable EJBookFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [EJBook fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

EJBook *_Nullable EJBookFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return EJBookFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable EJBookToData(EJBook *book, NSError **error)
{
    @try {
        id json = [book JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable EJBookToJSON(EJBook *book, NSStringEncoding encoding, NSError **error)
{
    NSData *data = EJBookToData(book, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation EJBook
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"error": @"error",
        @"title": @"title",
        @"subtitle": @"subtitle",
        @"authors": @"authors",
        @"publisher": @"publisher",
        @"language": @"language",
        @"isbn10": @"isbn10",
        @"isbn13": @"isbn13",
        @"pages": @"pages",
        @"year": @"year",
        @"rating": @"rating",
        @"desc": @"desc",
        @"price": @"price",
        @"image": @"image",
        @"url": @"url",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return EJBookFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return EJBookFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[EJBook alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:EJBook.properties.allValues];
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return EJBookToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return EJBookToJSON(self, encoding, error);
}
@end

NS_ASSUME_NONNULL_END
