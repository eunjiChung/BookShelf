//
//  BaseViewController.m
//  EJBookShelf
//
//  Created by CHUNGEUNJI on 25/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Alert Controller
- (void)showErrorAlert:(NSError *)error {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ERROR"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Public Method
- (NSMutableAttributedString *)generateHyperlink:(NSString *)url {
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:url];
    [attributedString addAttribute:NSLinkAttributeName value:url range:NSMakeRange(0, url.length)];
    return attributedString;
}


@end
