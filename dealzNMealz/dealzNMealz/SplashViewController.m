//
//  ViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "SplashViewController.h"
#import "SWRevealViewController.h"
@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(moveToLogin) withObject:nil afterDelay:3];
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)moveToLogin {
    BOOL isLoggedID = [[NSUserDefaults standardUserDefaults]boolForKey:@"isLoggedIn"];
    if (isLoggedID == YES) {
        //revealNavID
        SWRevealViewController *swreveal = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self.navigationController initWithRootViewController:swreveal];
    } else {
         [self performSegueWithIdentifier:@"splashToLogin" sender:nil];
    }
   
   // [self performSegueWithIdentifier:@"splashToLogin" sender:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
