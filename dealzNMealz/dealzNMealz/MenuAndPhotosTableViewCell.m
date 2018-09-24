//
//  MenuAndPhotosTableViewCell.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/6/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "MenuAndPhotosTableViewCell.h"

@implementation MenuAndPhotosTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.menuImagesScrollView.showsHorizontalScrollIndicator = NO;
    self.photosScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
