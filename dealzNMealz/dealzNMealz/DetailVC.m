//
//  DetailVC.m
//  dealzNMealz
//
//  Created by siva sandeep on 12/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "DetailVC.h"
#import "DetailImagesCell.h"
#import "DetailAddressCell.h"
#import "DetailTitleCell.h"
#import "NetworkManager.h"
#import "URLList.h"
#import "GlobalWidgets.h"
#import "AsyncImageView.h"
#import "Utils.h"
#import "LocationManager.h"
@interface DetailVC ()<UIScrollViewDelegate>
{
    NSDictionary *detailsDict;
    UIPageControl *page;
    CGFloat latitude,longitude;
    LocationManager* location;
}
@property (weak, nonatomic) IBOutlet UITableView *detailTblView;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    location = [LocationManager sharedInstance];
    self.menuButon.hidden = YES;
    [self creatingBackButtonWithImage:@"back"];
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    detailsDict = [[NSDictionary alloc]init];
    _detailTblView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self getDetailsFromServer];
    
    // Do any additional setup after loading the view.
}

- (void)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getDetailsFromServer {
    
    [[NetworkManager sharedInstance]getDataFromServerURL:[NSString stringWithFormat:@"%@1&restid=%@",_baseUrl,_resto_ID] withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                if([response isKindOfClass:[NSArray class]]){
                    NSArray *detailsArray = (NSArray *)response;
                    detailsDict = (NSDictionary*)[detailsArray objectAtIndex:0];
                }else if([response isKindOfClass:[NSDictionary class]]){
                    detailsDict = (NSDictionary*)response;
                }
                if ([[detailsDict allKeys] containsObject:@"error"]) {
                    [GlobalWidgets showAlertWithMessage:[detailsDict valueForKey:@"error"]];
                } else {
                    [_detailTblView reloadData];
                }
                NSLog(@"response is %@",response);
            }
        } else {
            [GlobalWidgets showAlertWithMessage:@"Server seems to be down"];

        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return  200;
    } else  if (indexPath.row == 1) {
        return  160;
    }  else  if (indexPath.row == 2) {
        return  241;
    }
    return  10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        DetailImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailImageCellID"];
        [self addImagesToScroll:cell];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    } else  if (indexPath.row == 1) {
        
        DetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCellID"];
        /*
         *  uncomment the below line once api is integrated and add api values to these labels
         */
        cell.restoOpenStatus.text = [detailsDict valueForKey:@"openinghours"];
        cell.restoMorningTimesLbl.text = [detailsDict valueForKey:@"morning_time"];
        cell.restoEveTimingsLbl.text = [detailsDict valueForKey:@"evening_time"];
        cell.restoRatingsLbl.text = [NSString stringWithFormat:@"%d",[[detailsDict valueForKey:@"rating"]intValue]];
        cell.restoTitle.text = [detailsDict valueForKey:@"name"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    } else  if (indexPath.row == 2) {
        //addressCell
        DetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailsAdressCellID"];
        
        
        [cell.bookTblBtn addTarget:self action:@selector(bookTblBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        latitude = [[detailsDict valueForKey:@"latitude"]floatValue];
        longitude = [[detailsDict valueForKey:@"longitude"]floatValue];
        NSString *mapUrlStr = [Utils getMapImageUrlWithLat:latitude andLong:longitude];
       NSURL *imgUrl = [NSURL URLWithString:[mapUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
        cell.locationImage.imageURL = imgUrl;
       // cell.locationImage.image = [Utils getImageFromLat:latitude andLong:longitude];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapTap)];
        tap.numberOfTapsRequired = 1;
        [cell.locationImage addGestureRecognizer:tap];
        
        cell.addresslbl.text = [detailsDict valueForKey:@"address"];
        cell.categoryStyleLbl.text = [detailsDict valueForKey:@"category"];
        [cell.mobileNumBtn setTitle:[detailsDict valueForKey:@"contact"] forState:UIControlStateNormal];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

- (void)mapTap {
    CGFloat userLat = location.locationManager.location.coordinate.latitude;
    CGFloat userLong = location.locationManager.location.coordinate.longitude;
    //saddr=\(from.latitude),\(from.longitude)&daddr=\(to.latitude),\(to.longitude)
    NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f",userLat,userLong,latitude,longitude];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    
}

- (void)bookTblBtnClick:(UIButton *)sender {
    NSString *bookTblApi = [NSString stringWithFormat:@"%@1&uid=%@&rid=%@",BOOK_TBL_URL,@"31",_resto_ID];
    [self callBookTblAPI:bookTblApi];
    
}


- (void)callBookTblAPI:(NSString *)str {
    [[NetworkManager sharedInstance]getDataFromServerURL:str withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
               NSDictionary * bookTblDict = (NSDictionary*)response;
                if ([[bookTblDict allKeys] containsObject:@"message"]) {
                    [GlobalWidgets showAlertWithMessage:[bookTblDict valueForKey:@"message"]];
                } else {
                    [GlobalWidgets showAlertWithMessage:@"Error while booking table"];
                }
                NSLog(@"response is %@",response);
            } else {
                [GlobalWidgets showAlertWithMessage:@"Error while booking table"];
            }
        } else {
            [GlobalWidgets showAlertWithMessage:@"Server seems to be down"];
        }
    }];
}


- (void)addImagesToScroll:(DetailImagesCell *)cell {
    NSDictionary *imageArray = [(NSDictionary *)detailsDict valueForKey:@"sliderimg"];
    for (int i=0; i<imageArray.allKeys.count; i++) {
        AsyncImageView *img = [[AsyncImageView alloc]initWithFrame:CGRectMake(i*[[UIScreen mainScreen]bounds].size.width, 0, [[UIScreen mainScreen]bounds].size.width, 200)];
      //  img.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageUrl = [imageArray valueForKey:[NSString stringWithFormat:@"images_%d",i]];
        img.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_IMAGE_URL,imageUrl]];
        [cell.detailImagesScroll addSubview:img];
    }
    cell.detailImagesScroll.contentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width*imageArray.allKeys.count, 200);
    cell.pagControl.numberOfPages = imageArray.allKeys.count;
    page = cell.pagControl;
    cell.detailImagesScroll.delegate = self;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    page.currentPage = point.x/[[UIScreen mainScreen]bounds].size.width;

    
}

@end
