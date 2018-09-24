//
//  ListTableViewCell.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/9/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _listBackGroundView.layer.cornerRadius = 5;
    _listBackGroundView.layer.borderWidth = 1;
    _listBackGroundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _listBackGroundView.clipsToBounds = YES;
    
    _restoImage.layer.cornerRadius = 5;
    _restoImage.clipsToBounds = YES;
    
    _restoMapsIcon.layer.cornerRadius = 5;
    _restoMapsIcon.clipsToBounds = YES;
    
    _ratingView.layer.cornerRadius = 5;
    _ratingView.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
