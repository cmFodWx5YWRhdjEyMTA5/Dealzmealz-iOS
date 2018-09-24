//
//  HomeViewController.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "BaseViewController.h"
@interface HomeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *bannerBackGroundView;

@property (weak, nonatomic) IBOutlet UIButton *previousBannerButton;
@property (weak, nonatomic) IBOutlet UIButton *nextBannerButton;
- (IBAction)nextBanerButtonClick:(UIButton *)sender;
- (IBAction)previousBannerButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *horizontalScroll;

@end
