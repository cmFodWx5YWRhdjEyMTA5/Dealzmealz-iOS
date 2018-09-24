//
//  ViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL isLoggedID = [[NSUserDefaults standardUserDefaults]boolForKey:@"isLoggedIn"];
    if (isLoggedID == YES) {
       // [self performSelector:@selector(moveToLogin) withObject:nil afterDelay:3];
        NSLog(@" move to home screen");
    } else {
        [self performSelector:@selector(moveToLogin) withObject:nil afterDelay:3];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)moveToLogin {
    [self performSegueWithIdentifier:@"splashToLogin" sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
