//
//  SideMenuViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/2/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "SideMenuViewController.h"
#import "LoginViewController.h"
@interface SideMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *menuItemsArray;
}
@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItemsArray = [[NSArray alloc]initWithObjects:@"Home",@"Profile",@"Logout", nil];
    _menuTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITABLE VIEW DELEGATES AND DATASOURCES
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuItemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simple"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[menuItemsArray objectAtIndex:indexPath.row]];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [self performSegueWithIdentifier:@"sidemenuToHome" sender:nil];
    } else  if (indexPath.row == 1) {
        
        [self performSegueWithIdentifier:@"sideMenuToProfile" sender:nil];
    } else  if (indexPath.row == 2)  {

        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:[LoginViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
        
    }
    
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
