//
//  ListTableViewCell.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/9/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "TPFloatRatingView.h"
@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *listBackGroundView;
@property (weak, nonatomic) IBOutlet AsyncImageView *restoImage;
@property (weak, nonatomic) IBOutlet UILabel *restoName;
@property (weak, nonatomic) IBOutlet UILabel *restoAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *restoMobileNumLabel;
@property (weak, nonatomic) IBOutlet AsyncImageView *restoMapsIcon;
@property (weak, nonatomic) IBOutlet UILabel *ratingLbl;
@property (weak, nonatomic) IBOutlet TPFloatRatingView *ratingView;

@end
