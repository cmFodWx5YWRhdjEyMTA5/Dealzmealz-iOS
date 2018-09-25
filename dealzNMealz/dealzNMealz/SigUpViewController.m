//
//  SigUpViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/2/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "SigUpViewController.h"
#import "Header.h"
@interface SigUpViewController ()<UITextFieldDelegate> {
    NSString *receivedOtpString,*eToken;
}
@property (weak, nonatomic) IBOutlet UILabel *mobileNumLbl;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumTf;
@property (weak, nonatomic) IBOutlet UITextField *dobTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confrmBtnTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signUpTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otpViewTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cofrinBtnBottom;
@property (weak, nonatomic) IBOutlet UITextField *otpTF;

@end

@implementation SigUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    receivedOtpString = @"";
    [self loadViewIfNeeded];
    [self viewDidLayoutSubviews];
    [self updateUi];
    _otpViewTop.constant = [UIScreen mainScreen].bounds.size.height;
    UIDatePicker*datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.dobTF.inputView = datePicker;
    
    // Do any additional setup after loading the view.
}

- (void)datePickerValueChanged:(UIDatePicker *)picker {
    NSLog(@"picker is %@",picker.date);
    _dobTF.text = [self getCurrentDate:picker.date];
    
}

- (NSString *)getCurrentDate:(NSDate *)date{
  
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"dd/MM/yyyy"];
    

    NSString *dateFromString = [newDateFormatter stringFromDate:date];
    
    return dateFromString;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUi {
    _confrmBtnTop.constant = (_confrmBtnTop.constant/667)*[UIScreen mainScreen].bounds.size.height;
     _cofrinBtnBottom.constant = (_cofrinBtnBottom.constant/667)*[UIScreen mainScreen].bounds.size.height;
    _signUpTop.constant = (_signUpTop.constant/667)*[UIScreen mainScreen].bounds.size.height;
    
}


- (IBAction)backButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)submitBtnClick:(UIButton *)sender {
    
    if (_userNameTF.text.length == 0) {
         [self showAlertWithError:ENTER_USERNAME];
    } else if (_emailTF.text.length == 0) {
        [self showAlertWithError:ENTER_EMAIL];
    } else if (_passwordTF.text.length == 0) {
         [self showAlertWithError:ENTER_PASSWORD];
    } else if (_confirmPasswordTF.text.length == 0) {
         [self showAlertWithError:ENTER_CONFIRM_PASSWORD];
    }  else if (![_confirmPasswordTF.text isEqualToString:_passwordTF.text]) {
        [self showAlertWithError:PASSWORD_DOESNT_MATCH];
    }else if (_mobileNumTf.text.length == 0) {
         [self showAlertWithError:ENTER_MOBILE_NUMBER];
    } else if (_dobTF.text.length == 0) {
         [self showAlertWithError:ENTER_DOD];
    } else {
        NSLog(@"Call Sign up api");
       /*
        */
        [self signUpCall];
        
    }
    
}


- (void)signUpCall {
   
    NSString *userName = _userNameTF.text;
    userName = [userName stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *str = [NSString stringWithFormat:@"%@%@&mob=%@&email=%@&birth=%@&username=%@&password=%@",SIGNUP_OTP_RECEIVE_URL,userName,_mobileNumTf.text,_emailTF.text,_dobTF.text,userName,_passwordTF.text];
    
    
    [[NetworkManager sharedInstance]getDataFromServerURL:str withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
       // [self getBannerDetailsFromServer];
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                 NSLog(@"response is %@",response);
                NSDictionary *responseDict =(NSDictionary *)response;
                if([[responseDict allKeys]containsObject:@"user_id"]) {
                    NSString *userID = [responseDict valueForKey:@"user_id"];
                    [self.navigationController popViewControllerAnimated:NO];
                    [self showAlertWithError:@"Successfully created account please login to continue"];
                } else if([[responseDict allKeys]containsObject:@"message"]) {
                    [self showAlertWithError:[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"message"]]];
                }
                
            } else {
                [self showAlertWithError:@"Sign up Failed .."];
            }
            
        } else {
            [self showAlertWithError:error.description];
        }
    }];
}


- (IBAction)alreaadyuserClick:(UIButton *)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)showAlertWithError:(NSString *)message {
    
    UIAlertController *alert = [GlobalWidgets showAlertWithTitle:message yesButtonTitle:@"OK" noButtonTitle:nil];
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window.rootViewController presentViewController:alert animated:true completion:nil];
    //[window presentViewController:alert animated:YES completion:nil];
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _userNameTF) {
        [_emailTF becomeFirstResponder];
    } else if (textField == _emailTF) {
        [_passwordTF becomeFirstResponder];
    } else if (textField == _passwordTF) {
        [_confirmPasswordTF becomeFirstResponder];
    } else if (textField == _confirmPasswordTF) {
        [_mobileNumTf becomeFirstResponder];
    } else if (textField == _mobileNumTf) {
        [_dobTF becomeFirstResponder];
    } else if (textField == _dobTF) {
        [_dobTF resignFirstResponder];
    }
    
    return YES;
}
- (IBAction)otpCloseBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:5 animations:^{
        _otpViewTop.constant = [UIScreen mainScreen].bounds.size.height;
    }];
}
- (IBAction)otpSubmitBtmClick:(UIButton *)sender {
    if (_otpTF.text.length == 0) {
        [self showAlertWithError:@"Enter OTP"];
    } else if (![_otpTF.text isEqualToString:receivedOtpString]) {
         [self showAlertWithError:@"OTP not matched"];
        
    }else {
        
        [self sendRegistrationDataToServer];
      
    }
   
}
- (void)sendRegistrationDataToServer {
    //
  //  &email=[xxxx@gmail.com]&birth=[dd/mm/yyyy]&name=[smeasofUserNamexxxx]&password=[abcd]&otp=[7ANU4O]&etoken=[d851b0c99e92bdd1b9224efe5204814d]
    NSString *str = [NSString stringWithFormat:@"%@%@&uname=%@&email=%@&birth=%@&name=%@&password=%@&otp=%@&etoken=%@",SIGNUP_RECEIVE_URL,_mobileNumTf.text,_userNameTF.text,_emailTF.text,_dobTF.text,_userNameTF.text,_passwordTF.text,_otpTF.text,eToken];
    
    
    
    [[NetworkManager sharedInstance]getDataFromServerURL:str withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        // [self getBannerDetailsFromServer];
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                NSLog(@"response is %@",response);
                
                
                
                [UIView animateWithDuration:5 animations:^{
                    _otpViewTop.constant = [UIScreen mainScreen].bounds.size.height;
                }];
                
                [self.navigationController popViewControllerAnimated:YES];
                [self showAlertWithError:[NSString stringWithFormat:@"%@",[response valueForKey:@"message"]]];
                
            
                
                
            } else {
                
                [self showAlertWithError:@"Sign up Failed .."];
            }
            
        }
        
        
    }];
    
}


@end
