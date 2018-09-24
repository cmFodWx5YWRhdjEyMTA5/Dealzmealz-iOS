//
//  Utils.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "GlobalWidgets.h"

@implementation GlobalWidgets

+ (UIAlertController *)showAlertWithTitle:(NSString *)title yesButtonTitle:(NSString *)yesButton noButtonTitle:(NSString *)nobutton {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
  
   
    if (yesButton == nil || [yesButton isEqualToString:@""]) {
      
    } else {
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:yesButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:yesAction];
    }
    if (nobutton == nil || [nobutton isEqualToString:@""]) {
    } else {
        UIAlertAction *noAction = [UIAlertAction actionWithTitle:nobutton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:noAction];

    }
       return alert;
}



+(void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [GlobalWidgets showAlertWithTitle:message yesButtonTitle:@"OK" noButtonTitle:nil];
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window.rootViewController presentViewController:alert animated:true completion:nil];
    //[window presentViewController:alert animated:YES completion:nil];
}


@end
