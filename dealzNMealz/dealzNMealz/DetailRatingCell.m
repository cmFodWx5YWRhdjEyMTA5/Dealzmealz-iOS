//
//  DetailRatingCell.m
//  dealzNMealz
//
//  Created by siva sandeep on 25/09/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import "DetailRatingCell.h"

@implementation DetailRatingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)rating1:(UIButton *)sender {
    //96 205 54
    _rating1.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
     _rating2.backgroundColor = [UIColor darkGrayColor];
     _rating3.backgroundColor = [UIColor darkGrayColor];
     _rating4.backgroundColor = [UIColor darkGrayColor];
     _rating5.backgroundColor = [UIColor darkGrayColor];
    [self.ratingDelegate ratingValue:1];
}

- (IBAction)rating2:(UIButton *)sender {
    _rating1.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating2.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating3.backgroundColor = [UIColor darkGrayColor];
    _rating4.backgroundColor = [UIColor darkGrayColor];
    _rating5.backgroundColor = [UIColor darkGrayColor];
 [self.ratingDelegate ratingValue:2];
}

- (IBAction)rating3:(UIButton *)sender {
    _rating1.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating2.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating3.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating4.backgroundColor = [UIColor darkGrayColor];
    _rating5.backgroundColor = [UIColor darkGrayColor];
     [self.ratingDelegate ratingValue:3];
}

- (IBAction)rating4:(UIButton *)sender {
    _rating1.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating2.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating3.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating4.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating5.backgroundColor = [UIColor darkGrayColor];
     [self.ratingDelegate ratingValue:4];
}

- (IBAction)rating5:(UIButton *)sender {
    _rating1.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating2.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating3.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating4.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
    _rating5.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
     [self.ratingDelegate ratingValue:5];
}
@end
