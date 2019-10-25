// To parse this JSON:
//
//   NSError *error;
//   EJBook *book = [EJBook fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class EJBook;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface EJBook : NSObject
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

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;

@end

NS_ASSUME_NONNULL_END
