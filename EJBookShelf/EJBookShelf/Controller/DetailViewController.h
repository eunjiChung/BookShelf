//
//  DetailViewController.h
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : BaseViewController

@property (assign, nonatomic) NSString *isbn13;

@end

NS_ASSUME_NONNULL_END
