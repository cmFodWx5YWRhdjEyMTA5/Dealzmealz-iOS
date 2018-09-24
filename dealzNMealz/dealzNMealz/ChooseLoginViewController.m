//
//  ChooseLoginViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 10/8/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "ChooseLoginViewController.h"

@interface ChooseLoginViewController ()

@end

@implementation ChooseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _signInButton.frame =CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-35, [UIScreen mainScreen].bounds.size.width-50, 30);
        _signUpButton.frame =CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2+5, [UIScreen mainScreen].bounds.size.width-50, 30);
    [UIView animateWithDuration:1 animations:^{
        _signInButton.frame =CGRectMake(25, [UIScreen mainScreen].bounds.size.height/2-35, [UIScreen mainScreen].bounds.size.width-50, 30);
        [self performSelector:@selector(moveAfterSomeTime) withObject:nil afterDelay:0.2];
    }];
    // Do any additional setup after loading the view.
}

- (void)moveAfterSomeTime {
    [UIView animateWithDuration:1 animations:^{
        _signUpButton.frame =CGRectMake(25, [UIScreen mainScreen].bounds.size.height/2+5, [UIScreen mainScreen].bounds.size.width-50, 30);
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
