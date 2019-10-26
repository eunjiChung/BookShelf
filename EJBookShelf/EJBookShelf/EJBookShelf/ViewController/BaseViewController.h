//
//  BaseViewController.h
//  EJBookShelf
//
//  Created by CHUNGEUNJI on 25/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

- (void)showErrorAlert:(NSError *)error;
- (void)showDefaultAlert:(NSString *)title message:(NSString *)message;
- (NSMutableAttributedString *)generateHyperlink:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
