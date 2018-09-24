//
//  TitleTableViewCell.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/12/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *restoOpenStatus;
@property (weak, nonatomic) IBOutlet UILabel *restoOpeningHours;
@property (weak, nonatomic) IBOutlet UILabel *restoReviewsAndBookingslabel;
@property (weak, nonatomic) IBOutlet UILabel *restoDiscountsDaysLabels;
@property (weak, nonatomic) IBOutlet UILabel *offerLabel;

@end
