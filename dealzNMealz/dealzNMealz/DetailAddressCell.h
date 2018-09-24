//
//  DetailAddressCell.h
//  dealzNMealz
//
//  Created by siva sandeep on 12/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface DetailAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mobileNumBtn;
@property (weak, nonatomic) IBOutlet UILabel *addresslbl;
@property (weak, nonatomic) IBOutlet UILabel *categoryStyleLbl;
@property (weak, nonatomic) IBOutlet UIButton *bookTblBtn;
@property (weak, nonatomic) IBOutlet AsyncImageView *locationImage;

@end
