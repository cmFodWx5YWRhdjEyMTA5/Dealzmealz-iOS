//
//  ProfileViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/2/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "ProfileViewController.h"
#import "GlobalWidgets.h"
#import "LoginViewController.h"
#import "UserProfileDetailsTableViewCell.h"
@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *listArray,*listImagesArray;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    listArray = [[NSArray alloc]initWithObjects:@"My Account",@"Profile Details",@"Pass Book",@"Favourites",@"Referrals", @"Offers", @"Help", @"FAQs & Links", nil];
   listImagesArray = [[NSArray alloc]initWithObjects:@"home",@"passbook",@"Favourites",@"offers",@"referals",   nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Mark - TABLE VIEW DATASOURCES
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    //userInfoID
        UserProfileDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoID"];
        cell.userNameLabel.text = @"HELLO WORLD";
        cell.userPhoneNumberLabel.text = @"8987463561";
        cell.userEmailLabel.text = @"helloWorld@gmail.com";
        [cell.editButon addTarget:self action:@selector(editProfileClick) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[listArray objectAtIndex:indexPath.row]];
       if (indexPath.row == 1) {
            cell.imageView.image =   [UIImage imageNamed:@"home"];
        } else if (indexPath.row == 2) {
              cell.imageView.image = [UIImage imageNamed:@"passbook"];
        } else if (indexPath.row == 3) {
              cell.imageView.image = [UIImage imageNamed:@"favourite"];
        } else if (indexPath.row == 4) {
              cell.imageView.image = [UIImage imageNamed:@"offers"];
        } else if (indexPath.row == 5) {
              cell.imageView.image = [UIImage imageNamed:@"referals"];
        }
        //forward
         cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"forward"]];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UIAlertController *alert = [GlobalWidgets showAlertWithTitle:[NSString stringWithFormat:@"%@ Feature is Currently unavailable",[[listArray objectAtIndex:indexPath.row]capitalizedString]] yesButtonTitle:@"OK" noButtonTitle:nil];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark- edit profile action

- (void)editProfileClick {
    
    /*
     * edit profile fun here;
     */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logOutButtonClick:(UIButton *)sender {
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}
@end
