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
#import "DetailRatingCell.h"
#import "CustomerReviewTableViewCell.h"
#import "NetworkManager.h"
#import "URLList.h"
#import "GlobalWidgets.h"
#import "AsyncImageView.h"
#import "Utils.h"
#import "LocationManager.h"

@interface DetailVC ()<UIScrollViewDelegate,DetailsRatingProtocol,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *detailsDict;
    UIPageControl *page;
    CGFloat latitude,longitude;
    LocationManager* location;
    BOOL isReviewsPresent;
    NSArray *reviewsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *detailTblView;
@property (strong, nonatomic) IBOutlet UIView *reviewView;
@property (weak, nonatomic) IBOutlet UIView *ratingPopUpView;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _ratingPopUpView.layer.cornerRadius = 10;
    _ratingPopUpView.clipsToBounds = YES;
    
    _reviewTextView.layer.cornerRadius = 10;
    _reviewTextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _reviewTextView.layer.borderWidth = 1;
    _reviewTextView.clipsToBounds = YES;
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
                    if([[detailsDict allKeys]containsObject:@"reviews"]) {
                        reviewsArray = (NSArray *)[detailsDict valueForKey:@"reviews"];
                        if([reviewsArray count]>0) {
                            isReviewsPresent = true;
                        } else{
                            isReviewsPresent = false;
                        }
                    } else{
                        isReviewsPresent = false;
                    }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            return  200;
        } else  if (indexPath.row == 1) {
            return  210;
        }  else  if (indexPath.row == 2) {
            return  90;
        }  else  if (indexPath.row == 3) {
            return  241;
        }
    } else {
        return 90;
    }
  
    return  10;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return @"Reviews";
    } else {
        return @"";
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 4;
    } else {
        if (isReviewsPresent == YES) {
             return [reviewsArray count];
        } else {
             return 1;
        }
    }
    return 0;
}
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 1 ){
        UIView*headerView = [[UIView alloc]init];
        UILabel *headerLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        headerLbl.text = @"REVIEWS";
        [headerView addSubview:headerLbl];
        return  headerView;
    }
    return [[UIView alloc]init];
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
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
            if ([[[detailsDict valueForKey:@"openinghours"] lowercaseString] containsString:@"close"]) {
                cell.restoOpenStatus.textColor = [UIColor redColor];
            } else {
                cell.restoOpenStatus.textColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
            }
            cell.restoOpenStatus.text = [detailsDict valueForKey:@"openinghours"];
            cell.restoMorningTimesLbl.text = [detailsDict valueForKey:@"morning_time"];
            cell.restoEveTimingsLbl.text = [detailsDict valueForKey:@"evening_time"];
            cell.restoRatingsLbl.text = [NSString stringWithFormat:@"%d",[[detailsDict valueForKey:@"rating"]intValue]];
            cell.restoTitle.text = [detailsDict valueForKey:@"name"];
            cell.discountPercentLbl.text = [NSString stringWithFormat:@"DISCOUNT - %@",[detailsDict valueForKey:@"discount_percent"]];
            cell.discountMinAmountLbl.text = [NSString stringWithFormat:@"*DiscountAvailable on minimum bill of %d",[[detailsDict valueForKey:@"minimum_bill_amount"]intValue]];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        } else  if (indexPath.row == 2) {
            //addressCell
            DetailRatingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ratingCellID"];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.ratingDelegate = self;
            return cell;
        }else  if (indexPath.row == 3) {
            //addressCell
            DetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailsAdressCellID"];
             if ([[[detailsDict valueForKey:@"openinghours"] lowercaseString] containsString:@"close"]) {
                 cell.bookTblBtn.backgroundColor = [UIColor darkGrayColor];
                 cell.bookTblBtn.enabled = NO;
             } else {
                 cell.bookTblBtn.backgroundColor = [UIColor colorWithRed:96/255.0 green:205/255.0 blue:54/255.0 alpha:1];
                  cell.bookTblBtn.enabled = YES;
             }
            
            
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
    } else {
         CustomerReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewCellID"];
        if (isReviewsPresent == YES){
            NSDictionary *singleObj = [reviewsArray objectAtIndex:indexPath.row];
            cell.customerNameLbl.text = [singleObj objectForKey:@"name"];
            cell.customerReviewLbl.text = [singleObj objectForKey:@"review"];
            cell.customerRatingLbl.text  = [NSString stringWithFormat:@"%@",[singleObj objectForKey:@"rating"]];
            cell.cellBackgrounView.hidden = NO;
        } else {
            cell.cellBackgrounView.hidden = YES;
        }
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
    NSString *bookTblApi = [NSString stringWithFormat:@"%@1&uid=%@&rid=%@",BOOK_TBL_URL,[[NSUserDefaults standardUserDefaults]valueForKey:@"id"],_resto_ID];
    [self callBookTblAPI:bookTblApi];
    
}

- (void)ratingValue:(int)ratingValue {
    CGRect frame = self.view.bounds;
    _reviewView.frame = frame;
    [self.view addSubview:_reviewView];
    NSLog(@"Rating value is %d",ratingValue);
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
- (IBAction)reviewSubmitBtn:(id)sender {
    if(_reviewTextView.text.length > 0) {
    [self addReviewApiCall];
    } else {
        [GlobalWidgets showAlertWithMessage:@"Enter review to submit"];
    }
    
}
- (IBAction)reviewCancelBtn:(id)sender {
    [_reviewView removeFromSuperview];
}

- (void)addReviewApiCall {
    NSString *ratingUrl = [NSString stringWithFormat:@"%@%@&rating=%d&restid=%@&userid=%@",ADD_REVIEW_URL,_reviewTextView.text,3,_resto_ID,[[NSUserDefaults standardUserDefaults]valueForKey:@"id"]];
    [[NetworkManager sharedInstance]getDataFromServerURL:ratingUrl withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        _reviewTextView.text = @"";
        [_reviewView removeFromSuperview];
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                NSDictionary * ratingDict = (NSDictionary*)response;
                if ([[ratingDict allKeys] containsObject:@"message"]) {
                    [GlobalWidgets showAlertWithMessage:[ratingDict valueForKey:@"message"]];
                } else {
                    [GlobalWidgets showAlertWithMessage:@"Error while giving review"];
                }
                NSLog(@"response is %@",response);
            } else {
                [GlobalWidgets showAlertWithMessage:@"Error while giving review"];
            }
        } else {
            [GlobalWidgets showAlertWithMessage:@"Server seems to be down"];
        }
    }];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}
@end
