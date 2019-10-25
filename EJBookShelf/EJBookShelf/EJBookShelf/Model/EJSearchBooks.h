// To parse this JSON:
//
//   NSError *error;
//   EJSearchBooks *searchBooks = [EJSearchBooks fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class EJSearchBooks;
@class EJBook;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface EJSearchBooks : NSObject
@property (nonatomic, copy) NSString *error;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSArray<EJBook *> *books;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface EJBook : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *isbn13;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *url;
@end

NS_ASSUME_NONNULL_END
