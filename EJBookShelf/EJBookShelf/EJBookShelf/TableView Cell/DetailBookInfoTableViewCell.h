//
//  DetailBookInfoTableViewCell.h
//  EJBookShelf
//
//  Created by CHUNGEUNJI on 25/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailBookInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookSubtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPublisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookIsbn10Label;
@property (weak, nonatomic) IBOutlet UILabel *bookIsbn13Label;
@property (weak, nonatomic) IBOutlet UILabel *bookPages;
@property (weak, nonatomic) IBOutlet UILabel *bookYear;
@property (weak, nonatomic) IBOutlet UILabel *bookLanguage;
@property (weak, nonatomic) IBOutlet UITextView *bookUrl;


@end

NS_ASSUME_NONNULL_END
