//
//  MostViewedViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/9/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "MostViewedViewController.h"
#import "NetworkManager.h"
#import "URLList.h"
#import "ListTableViewCell.h"
#import "AsyncImageView.h"
#import "StaticMessages.h"
#import "Utils.h"
#import "DetailVC.h"
@interface MostViewedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
  
    __weak IBOutlet UICollectionView *bannerCollectionView;
    int index;
    __weak IBOutlet UITableView *restoTableList;
    NSDictionary *responseDict;
    NSString *restoUrl;
    NSArray *restoListArray;
    NSString *restoID;
    NSString *baseDetailUrl;
}
@property (weak, nonatomic) IBOutlet UILabel *noRestaurentsLabel;
@end

@implementation MostViewedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // _bannerImagesArray = [[NSArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg", nil];
   
    _noRestaurentsLabel.hidden = YES;
    self.menuButon.hidden = YES;
    [self creatingBackButtonWithImage:@"back"];
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    restoTableList.hidden = YES;
  
    if ([self.selectedTabName isEqualToString:@"discount"]) {

        NSString * discountURl = [NSString stringWithFormat:@"%@1&discid=%@",DISCOUNT_DETAILS_RESTAURENTS_URL,self.discountID];
        restoUrl = discountURl;
        baseDetailUrl = DISC_RESTO_DETAIL_URL;
        [self getDataFromServer:restoUrl];
    }  else if ([self.selectedTabName isEqualToString:@"offer"]) {
        //https://dealznmealz.com/mobileapi.php?offdetails=1&offid=38
        NSString * discountURl = [NSString stringWithFormat:@"%@1&offid=%@",OFFER_DETAILS_RESTAURENTS_URL,self.discountID];
        restoUrl = discountURl;
        baseDetailUrl = DISC_RESTO_DETAIL_URL;
        [self getDataFromServer:restoUrl];
    }else {
        if ([self.selectedTabName isEqualToString:@"search"]) {
            restoUrl = MOST_SEARCHED_RESTO_URL;
            baseDetailUrl = SEARCHED_RESTO_DETAIL_URL;
            
        } else  if ([self.selectedTabName isEqualToString:@"reviewed"]) {
            restoUrl = REVIEWED_RESTO_URL;
            baseDetailUrl = REVIEWED_RESTO_DETAIL_URL;
        } else  if ([self.selectedTabName isEqualToString:@"latest"]) {
            restoUrl = LATEST_RESTO_URL;
            baseDetailUrl = LATEST_RESTO_DETAIL_URL;
        }
        NSString *urlStr = [NSString stringWithFormat:@"%@1",restoUrl];
        [self getDataFromServer:urlStr];
    }
    // Do any additional setup after loading the view.
}

- (void)getDataFromServer:(NSString *)urlStr {
    
    [[NetworkManager sharedInstance]getDataFromServerURL:urlStr withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        
        NSLog(@"response is %@",response);
       
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                [bannerCollectionView reloadData];
                NSString *responseString = [NSString stringWithFormat:@"%@",(NSString *)[response description]];
                if ([responseString isEqualToString:NO_RESTO_AVAILABLE]) {
                    restoTableList.hidden = YES;
                    _noRestaurentsLabel.hidden = NO;
                } else {
                    restoListArray = (NSArray *)response;
                    restoTableList.hidden = NO;
                    _noRestaurentsLabel.hidden = YES;
                    [restoTableList reloadData];
                }
               
            }
        }
    }];
}


- (void)backButtonClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    index = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collection view Delegates and Data source
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView != bannerCollectionView) {
        
    }
    return UIEdgeInsetsZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
   
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
        return [_bannerImagesArray count];
  
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
        UICollectionViewCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannerID" forIndexPath:indexPath];
    NSDictionary *singleDict = [_bannerImagesArray objectAtIndex:indexPath.row];
    /*
     *  UNCOMMENT THE BELOW LINE AND PASS THE IMAGE URL IN THE BELOW LINE
     */
    AsyncImageView *bannerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, bannerCell.bounds.size.width, bannerCell.bounds.size.height)];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            bannerImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_IMAGE_URL,[singleDict valueForKey:@"image"]]];

        });
    
  
    
    [bannerCell addSubview:bannerImage];
    return bannerCell;
    //
}

#pragma mark - Next Click
- (IBAction)nextBanerButtonClick:(UIButton *)sender {
    if (bannerCollectionView) {
        if (index < _bannerImagesArray.count-1) {
            index = index+1;
            
            [bannerCollectionView setContentOffset:CGPointMake(index*(CGRectGetWidth(bannerCollectionView.frame)), 0) animated:YES];
            
        }
    }
    
    
}
#pragma mark - Previous Click
- (IBAction)previousBannerButtonClick:(UIButton *)sender {
    if (bannerCollectionView) {
        if (index >0) {
            index = index-1;
            [bannerCollectionView setContentOffset:CGPointMake(index*(CGRectGetWidth(bannerCollectionView.frame)), 0) animated:YES];
            
        }
    }
}



#pragma mark - Table View Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [restoListArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       
    ListTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"listID"];
    NSDictionary *singleDict = [restoListArray objectAtIndex:indexPath.row];
    if ([[singleDict allKeys]containsObject:@"img"]) {
        cell.restoImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_IMAGE_URL,[singleDict valueForKey:@"img"]]];
    } else {
        cell.restoImage.image = [UIImage imageNamed:@"NoImage"];
    }
   // cell.ratingView = 
    cell.restoName.text =[singleDict valueForKey:@"name"];
    cell.restoAddressLabel.text =[NSString stringWithFormat:@"%@",[singleDict valueForKey:@"address"]];
    [cell.restoAddressLabel sizeToFit];
    
    cell.ratingLbl.text = [NSString stringWithFormat:@"%@/5",[singleDict valueForKey:@"rating"]];
    
    
    CGFloat lat = [[singleDict valueForKey:@"latitude"]floatValue];
    CGFloat lon = [[singleDict valueForKey:@"longitude"]floatValue];
    
    NSString *mapUrlStr = [Utils getMapImageUrlWithLat:lat andLong:lon];
    NSURL *imgUrl = [NSURL URLWithString:[mapUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    cell.restoMapsIcon.imageURL = imgUrl;
    cell.restoMapsIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapTap:)];
    tap.numberOfTapsRequired = 1;
    tap.view.tag = indexPath.row;
    [cell.restoMapsIcon addGestureRecognizer:tap];
    //cell.restoMobileNumLabel.text =[singleDict valueForKey:@"restoPhoneNumber"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)mapTap:(UITapGestureRecognizer*)tap{
    int index = (int)tap.view.tag;
    NSDictionary *singleDict = [restoListArray objectAtIndex:index];
    CGFloat lat = [[singleDict valueForKey:@"latitude"]floatValue];
    CGFloat lon = [[singleDict valueForKey:@"longitude"]floatValue];
    NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=%f,%f",lat,lon];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    
}



//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *singleDict = [restoListArray objectAtIndex:indexPath.row];
    restoID = [singleDict valueForKey:@"id"];
    [self performSegueWithIdentifier:@"mostViewdToDetails" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"mostViewdToDetails"]) {
        DetailVC *detail = segue.destinationViewController;
        detail.resto_ID = restoID;
        detail.baseUrl = baseDetailUrl;
        
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
