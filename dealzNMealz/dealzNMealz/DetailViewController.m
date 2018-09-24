//
//  DetailViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/3/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailsImagesTableViewCell.h"
#import "MenuAndPhotosTableViewCell.h"
#import "ZoomImageViewController.h"
#import "TitleTableViewCell.h"
#import "ReviewsTableViewCell.h"
#import "AddressTableViewCell.h"
@interface DetailViewController ()
{
    NSArray *menuImagesArray;
    NSArray *hotelImagesArray;
    NSString *selection;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuImagesArray = [[NSArray alloc]initWithObjects:@"menu1.jpg",@"menu2.jpg",@"menu3.jpg",@"menu4.jpg",@"menu5.jpg", nil];
    hotelImagesArray = [[NSArray alloc]initWithObjects:@"hotel1.jpg",@"hotel2.jpg",@"hotel3.jpg",@"hotel4.jpg",@"hotel5.jpg", nil];
    self.menuButon.hidden = YES;
    [self creatingBackButtonWithImage:@"back"];
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegates and datasource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
    tableFooterView.backgroundColor = [UIColor whiteColor];
    UIButton *bookATableButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bookATableButton.frame = CGRectMake((tableFooterView.bounds.size.width/2)-100, 5, 200, 35);
    [bookATableButton setTitle:@"Book A Table" forState:UIControlStateNormal];
    [bookATableButton setBackgroundImage:[UIImage imageNamed:@"BookATableImage"] forState:UIControlStateNormal];
    [tableFooterView addSubview:bookATableButton];
    return tableFooterView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return  200;
    } else  if (indexPath.row == 1) {
        return  190;
    }  else  if (indexPath.row == 2) {
        return  220;
    } else  if (indexPath.row == 3) {
        return  114;
    }else  if (indexPath.row == 4) {
        return  80;
    } else {
        return 44;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 0) {
        DetailsImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
        
        _detailsImageBackGroundView.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, cell.bounds.size.height);
        [cell addSubview:_detailsImageBackGroundView];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    } else  if (indexPath.row == 1) {
        
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleID"];
        /*
         *  uncomment the below line once api is integrated and add api values to these labels
         */
       //cell.restoOpenStatus.text = @"";
      //  cell.restoOpeningHours.text = @"";
      //  cell.restoDiscountsDaysLabels.text = @"";
      // cell.restoReviewsAndBookingslabel.text = @"";
        cell.titleLabel.text = @"Leela palace";
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    } else  if (indexPath.row == 2) {
        int imageWidth = ([UIScreen mainScreen].bounds.size.width)/4;
       
        MenuAndPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCellID"];
        UITapGestureRecognizer *menuTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnImageForZoom)];
        menuTap.numberOfTapsRequired = 1;
        [cell.menuImagesScrollView addGestureRecognizer:menuTap];
        
        UITapGestureRecognizer *hotelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnHotelImagesForZoom)];
        hotelTap.numberOfTapsRequired = 1;
        [cell.photosScrollView addGestureRecognizer:hotelTap];
        /*
         *  replace menu images and hotel images array  with api values
         */
        
        for (int i =0; i<[menuImagesArray count]; i++) {
            UIImageView *menuImage = [[UIImageView alloc]initWithFrame:CGRectMake((i*imageWidth), 0, imageWidth-10, cell.menuImagesScrollView.bounds.size.height)];
            menuImage.layer.cornerRadius = 10;
            menuImage.clipsToBounds = YES;
            menuImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[menuImagesArray objectAtIndex:i]]];
      
            [cell.menuImagesScrollView addSubview:menuImage];
        }
        cell.menuImagesScrollView.contentSize = CGSizeMake([menuImagesArray count] * imageWidth,  cell.menuImagesScrollView.bounds.size.height);
        
        for (int i =0; i<[hotelImagesArray count]; i++) {
            UIImageView *hotelImage = [[UIImageView alloc]initWithFrame:CGRectMake((i*imageWidth), 0, imageWidth-10, cell.photosScrollView.bounds.size.height)];
            hotelImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[hotelImagesArray objectAtIndex:i]]];
            hotelImage.layer.cornerRadius = 10;
            hotelImage.clipsToBounds = YES;
            [cell.photosScrollView addSubview:hotelImage];
        }
        cell.photosScrollView.contentSize = CGSizeMake([hotelImagesArray count] * imageWidth ,  cell.photosScrollView.bounds.size.height);
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    } else  if (indexPath.row == 3) {
        //addressCell
        AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
        
        /*
         *  uncomment the below line once api is integrated and add api values to these labels
         */
        //cell.addressLabel.text = @"";
      //  cell.mobileNumLabel.text = @"";
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 4){
        //reviewCellID
        ReviewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewCellID"];
        
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }  else {
        //reviewCellID
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_ID"];
        }
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"Hello World";
        return cell;
    }
    
}

- (void)tapOnImageForZoom {
    selection = @"menu";
    [self performSegueWithIdentifier:@"detailToZoomView" sender:nil];
}

- (void)tapOnHotelImagesForZoom {
    selection = @"hotel";
    [self performSegueWithIdentifier:@"detailToZoomView" sender:nil];
}



 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"detailToZoomView"] ) {
         ZoomImageViewController *zoom = segue.destinationViewController;
         if ([selection isEqualToString:@"menu"]) {
              zoom.imagesArray = menuImagesArray;
         } else {
             zoom.imagesArray = hotelImagesArray;
         }
        
     }
 }
 @end
