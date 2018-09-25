//
//  CustomerReviewTableViewCell.h
//  dealzNMealz
//
//  Created by siva sandeep on 25/09/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerReviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *customerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *customerReviewLbl;
@property (weak, nonatomic) IBOutlet UILabel *customerRatingLbl;
@property (weak, nonatomic) IBOutlet UIView *cellBackgrounView;

@end
