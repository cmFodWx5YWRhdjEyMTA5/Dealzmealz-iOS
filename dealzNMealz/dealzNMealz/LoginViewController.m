//
//  LoginViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"
#import "ForgetViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.userNameTextField setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
  
    
    
  /*  [UIView animateWithDuration:0.6 animations:^{
        
        self.loginBottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-160, [UIScreen mainScreen].bounds.size.width, 128);
        [self performSelector:@selector(callAfterSomeTime) withObject:nil afterDelay:0.6];
        
    }]; */
    // Do any additional setup after loading the view.
}
- (void)animationMethod {
    [UIView animateWithDuration:9 animations:^{
        
        _userNameXposConstraint.constant = 9;
       /* [UIView animateWithDuration:0.2 animations:^{
            _passwordXposConstraint.constant = 9;
            [UIView animateWithDuration:0.2 animations:^{
                _loginButtonXposConstraint.constant = 9;
                
            }];
        }];*/
    }];
}

- (void)callAfterSomeTime {
    
    [UIView animateWithDuration:0.6 animations:^{
          self.loginBottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-128, [UIScreen mainScreen].bounds.size.width, 128);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClick:(UIButton *)sender {
    if (_userNameTextField.text.length == 0) {
        [self showAlertWithError:ENTER_EMAIL];
    } else if (_passwordTextField.text.length == 0) {
        [self showAlertWithError:ENTER_PASSWORD];
    } else {
        [self doLogin];
        
    }
        
   
}


- (void)doLogin {
    
    //  &email=[xxxx@gmail.com]&birth=[dd/mm/yyyy]&name=[smeasofUserNamexxxx]&password=[abcd]&otp=[7ANU4O]&etoken=[d851b0c99e92bdd1b9224efe5204814d]
    NSString *str = [NSString stringWithFormat:@"%@%@&pass=%@",LOGIN_URL,_userNameTextField.text,_passwordTextField.text];
    
    
    
    [[NetworkManager sharedInstance]getDataFromServerURL:str withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        // [self getBannerDetailsFromServer];
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                
                NSDictionary *responseDict = (NSDictionary *)response;
                
                if ([[responseDict allKeys]containsObject:@"user_id"]) {
                     [self performSegueWithIdentifier:@"loginToHome" sender:nil];
                } else {
                    [self showAlertWithError:@"Invalid Credentials"];
                }
                
              
                _userNameTextField.text = @"";
                _passwordTextField.text = @"";
                
            } else {
                
                [self showAlertWithError:@"Login Failed .."];
            }
            
        }
        
        
    }];
    
}


- (IBAction)registerButtonClick:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"loginToSignUp" sender:nil];
    
}
- (IBAction)facebookButtonClick:(UIButton *)sender {
    [self showAlertWithError:CHOOSE_EMAIL_FOR_FACEBOOK];
}
- (IBAction)googleButtonClick:(UIButton *)sender {
    [self showAlertWithError:CHOOSE_EMAIL_FOR_GMAIL];
}
- (IBAction)forgotBtnClick:(UIButton *)sender {
    ForgetViewController *forgotVC= [self.storyboard instantiateViewControllerWithIdentifier:@"forgotVCID"];
    [self presentViewController:forgotVC animated:YES completion:nil];
}

- (void)showAlertWithError:(NSString *)message {
    
    UIAlertController *alert = [GlobalWidgets showAlertWithTitle:message yesButtonTitle:@"OK" noButtonTitle:nil];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
