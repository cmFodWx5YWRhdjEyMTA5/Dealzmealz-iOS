//
//  DetailTitleCell.m
//  dealzNMealz
//
//  Created by siva sandeep on 12/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import "DetailTitleCell.h"

@implementation DetailTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _restoRatingsLbl.layer.cornerRadius = 5;
    _restoRatingsLbl.clipsToBounds = YES;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
