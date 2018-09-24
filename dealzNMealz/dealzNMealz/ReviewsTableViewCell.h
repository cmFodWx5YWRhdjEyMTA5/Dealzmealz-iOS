//
//  ReviewsTableViewCell.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/12/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewsTableViewCell : UITableViewCell
- (IBAction)reviewsButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *reviewsButton;

@end
