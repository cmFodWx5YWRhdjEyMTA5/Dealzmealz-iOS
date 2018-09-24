//
//  DetailAddressCell.m
//  dealzNMealz
//
//  Created by siva sandeep on 12/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import "DetailAddressCell.h"

@implementation DetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bookTblBtn.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
