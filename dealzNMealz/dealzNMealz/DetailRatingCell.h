//
//  DetailRatingCell.h
//  dealzNMealz
//
//  Created by siva sandeep on 25/09/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailsRatingProtocol
- (void)ratingValue:(int)ratingValue;
@end

@interface DetailRatingCell : UITableViewCell
@property id<DetailsRatingProtocol> ratingDelegate;

- (IBAction)rating1:(UIButton *)sender;
- (IBAction)rating2:(UIButton *)sender;
- (IBAction)rating3:(UIButton *)sender;
- (IBAction)rating4:(UIButton *)sender;
- (IBAction)rating5:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *rating1;
@property (weak, nonatomic) IBOutlet UIButton *rating2;

@property (weak, nonatomic) IBOutlet UIButton *rating3;

@property (weak, nonatomic) IBOutlet UIButton *rating4;

@property (weak, nonatomic) IBOutlet UIButton *rating5;


@end
