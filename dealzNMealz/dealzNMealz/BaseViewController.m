//
//  BaseViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#define Y_POS 25

#import "BaseViewController.h"
#import "SWRevealViewController.h"
@interface BaseViewController ()
{
    SWRevealViewController *revealController;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    revealController = [self revealViewController];
    [self creatingNavigationView];
    // Do any additional setup after loading the view.
}

- (void)creatingNavigationView {
    
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    _navigationView.backgroundColor = [UIColor whiteColor];
    _menuButon = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButon.frame = CGRectMake(0, Y_POS, 60, 34);
    [_menuButon setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [_menuButon addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightCornerImage = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, Y_POS, 50, 34)];
    _rightCornerImage.image = [UIImage imageNamed:@"leftCorerImage"];
    
    _navigationLogo = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2)-25, Y_POS, 50, 34)];
    _navigationLogo.image = [UIImage imageNamed:@"navigationLogo"];

    
    //
    [self.navigationView addSubview:_rightCornerImage];
    [self.navigationView addSubview:_navigationLogo];
    [self.navigationView addSubview:_menuButon];
    [self.view addSubview:_navigationView];
}

- (void)creatingBackButtonWithImage:(NSString *)imageName {
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0, Y_POS, 60, 34);
    [_backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.navigationView addSubview:_backButton];
    
   
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
