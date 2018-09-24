//
//  BaseViewController.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property UIView *navigationView;
@property UIButton *menuButon;
@property UIImageView *rightCornerImage;
@property UIImageView *navigationLogo;

@property UIView *backButtonBackGroundView;
@property UIButton *backButton;
@property UILabel *titleLabel;


- (void)creatingBackButtonWithImage:(NSString *)imageName;

@end
