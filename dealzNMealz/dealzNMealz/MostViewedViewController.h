//
//  MostViewedViewController.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/9/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "BaseViewController.h"

@interface MostViewedViewController : BaseViewController

@property   NSArray *bannerImagesArray;
@property (weak, nonatomic) IBOutlet UIButton *previousBannerButton;
@property (weak, nonatomic) IBOutlet UIButton *nextBannerButton;
- (IBAction)nextBanerButtonClick:(UIButton *)sender;
- (IBAction)previousBannerButtonClick:(UIButton *)sender;
@property NSString *discountID;


@property NSString *selectedTabName;

@end
