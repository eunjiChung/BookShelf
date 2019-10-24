//
//  BookTableViewCell.h
//  EJBookShelf
//
//  Created by eunji on 23/10/2019.
//  Copyright © 2019 eunji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EJInfoBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookUrlLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookIsbnLabel;

@property (nonatomic, assign) EJInfoBook *book;

- (void)generateBookCell;

@end

NS_ASSUME_NONNULL_END
