//
//  Utils.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GlobalWidgets : NSObject

+ (UIAlertController *)showAlertWithTitle:(NSString *)title yesButtonTitle:(NSString *)yesButton noButtonTitle:(NSString *)nobutton;

+(void)showAlertWithMessage:(NSString *)message;
@end
