//
//  AppDelegate.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property UIActivityIndicatorView *indicator;


+ (AppDelegate *)appDelegate;
+ (void)startAnimating;
+ (void)stopAnimating;

@end

