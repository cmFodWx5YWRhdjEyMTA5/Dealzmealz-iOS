//
//  UserProfileDetailsTableViewCell.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/25/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;

@property (weak, nonatomic) IBOutlet UIButton *editButon;
@end
