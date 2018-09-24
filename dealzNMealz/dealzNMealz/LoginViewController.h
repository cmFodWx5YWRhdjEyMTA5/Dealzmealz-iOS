//
//  LoginViewController.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBottomConstaint;

@property (weak, nonatomic) IBOutlet UIView *loginBottomView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameXposConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordXposConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonXposConstraint;
- (IBAction)backButtonClick:(UIButton *)sender;

@end
