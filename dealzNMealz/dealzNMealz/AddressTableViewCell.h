//
//  AddressTableViewCell.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/12/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;
@end
