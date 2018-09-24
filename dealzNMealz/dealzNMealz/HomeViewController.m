//
//  HomeViewController.m
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/1/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "MostViewedViewController.h"
#import "NetworkManager.h"
#import "URLList.h"
#import "AsyncImageView.h"
#import "HomeFIlterModel.h"
#import "LeveyPopListView.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    
    __weak IBOutlet AsyncImageView *latestRestImage;
    __weak IBOutlet AsyncImageView *mostReviewdImage;
    __weak IBOutlet AsyncImageView *mostSerachedImage;
    __weak IBOutlet UICollectionView *bannerCollectionView;
    int index;
    __weak IBOutlet UIView *mostSearcdView;
    __weak IBOutlet UIView *mostReviewdView;
    __weak IBOutlet UIView *latestRestoView;
    NSString *selectedBottomTab;
    __weak IBOutlet UICollectionView *homeListCollectionView;
    NSDictionary *responseDict;
    NSArray *bannerImagesArray;
    NSArray *restoListArray;
    NSArray *horozontalImagesArray;
    NSString *ID;
    HomeFIlterLocationModel *filterLocationModel;
    HomeFIlterCategoryModel *filterCategoryModel;
    HomeFIlterPriceModel *filterPriceModel;
    __weak IBOutlet UIButton *byLocationBtn;
    __weak IBOutlet UIButton *byCostBtn;
    __weak IBOutlet UIButton *byCategoryBtn;
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    [self.view layoutSubviews];
    [self applyingBorderColorsToButtons];
    ID = @"";
    bannerImagesArray = [[NSArray alloc]init];
    filterCategoryModel = [[HomeFIlterCategoryModel alloc]init];
    filterLocationModel = [[HomeFIlterLocationModel alloc]init];
    filterPriceModel = [[HomeFIlterPriceModel alloc]init];

    [self addImagesToRestoTypes];
    [self addingGesturesToBottomViews];
    homeListCollectionView.hidden = YES;
    bannerCollectionView.hidden = YES;
    [self getDataFromServer];
    [self getFilterDataFromServer];
    
   
}

- (void)addImagesToRestoTypes {
    dispatch_async(dispatch_get_main_queue(), ^{
        mostReviewdImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",MOST_REVIEWED_IMAGE_URL]];
        latestRestImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",LATEST_RESTO_IMAGE_URL]];
        mostSerachedImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",MOST_SEARCHED_IMAGE_URL]];
    });
}
- (void)getDataFromServer {
    
    [[NetworkManager sharedInstance]getDataFromServerURL:[NSString stringWithFormat:@"%@1",HOME_PAGE_DISCOUNTS_URL] withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
         [self getBannerDetailsFromServer];
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                homeListCollectionView.hidden = NO;
               
                NSLog(@"response is %@",response);
                
                
                restoListArray = (NSMutableArray *)response;
                
                [homeListCollectionView reloadData];
            }
          
        }
        
        
    }];
}


- (void)getFilterDataFromServer {
    [[NetworkManager sharedInstance]getDataFromServerURL:[NSString stringWithFormat:@"%@",SEARCH_CATEGORY_URL] withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                NSArray *categoryArray = (NSArray *)response;
                [filterCategoryModel assignCategoryDataToModel: categoryArray];
            }
            
        }
        
    }];
    
    [[NetworkManager sharedInstance]getDataFromServerURL:[NSString stringWithFormat:@"%@",SEARCH_LOCATION_URL] withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                NSArray *locArray = (NSArray *)response;
                [filterLocationModel assignLocatioDataToModel: locArray];
            }
            
        }
        
    }];
}



- (void)getBannerDetailsFromServer {
    
    //https://dealznmealz.com/mobileapi.php?paidbanners=1
    [[NetworkManager sharedInstance]getDataFromServerURL:[NSString stringWithFormat:@"%@1",HOME_PAGE_BANNER_URL] withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        [self getHotDealsFromServer];
        if (error == nil) {
            if ([urlResponse statusCode]  == 200) {
                bannerCollectionView.hidden = NO;
                NSLog(@"response is %@",response);
                
                
                bannerImagesArray = (NSMutableArray *)response;
                
                [bannerCollectionView reloadData];
            }
        }
       
        
    }];
    
}


- (void)getHotDealsFromServer {
    [[NetworkManager sharedInstance]getDataFromServerURL:[NSString stringWithFormat:@"%@1",HOT_DEALS_URL] withCompletionHandler:^(NSError *error, id response, NSHTTPURLResponse *urlResponse) {
        
       
        NSLog(@"response is %@",response);
      
        horozontalImagesArray = (NSMutableArray *)response;
        dispatch_async(dispatch_get_main_queue(), ^{
        [self createHorozontalScroll:horozontalImagesArray];
        });
    }];
    
}
- (void)addingGesturesToBottomViews {
    
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seaarchedTap)];
    searchTap.numberOfTapsRequired = 1;
    [mostSearcdView addGestureRecognizer:searchTap];
    UITapGestureRecognizer *reviewdTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reviewdTapGesture)];
    reviewdTap.numberOfTapsRequired = 1;
    [mostReviewdView addGestureRecognizer:reviewdTap];
    
    UITapGestureRecognizer *latestRestoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(latestRestoTapGesture)];
    latestRestoTap.numberOfTapsRequired = 1;
    [latestRestoView addGestureRecognizer:latestRestoTap];
    
    
}

- (void)viewWillLayoutSubviews{
    //[homeListCollectionView reloadData];
}


- (void)seaarchedTap {
    selectedBottomTab = @"search";
    [self performSegueWithIdentifier:@"homeToMostView" sender:nil];
}

- (void)reviewdTapGesture {
     selectedBottomTab = @"reviewed";
      [self performSegueWithIdentifier:@"homeToMostView" sender:nil];
}


- (void)latestRestoTapGesture {
     selectedBottomTab = @"latest";
      [self performSegueWithIdentifier:@"homeToMostView" sender:nil];
}

- (void)viewWillAppear:(BOOL)animated {
     index = 0;
}

- (void)applyingBorderColorsToButtons {
    
   /* self.searchButton.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    self.searchButton.layer.borderWidth = 1.0;
    self.searchButton.clipsToBounds = YES;
    */
    byLocationBtn.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    byLocationBtn.layer.borderWidth = 1.0;
   byLocationBtn.clipsToBounds = YES;
    
    byCostBtn.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    byCostBtn.layer.borderWidth = 1.0;
    byCostBtn.clipsToBounds = YES;
    
   byCategoryBtn.layer.borderColor = [[UIColor darkGrayColor]CGColor];
   byCategoryBtn.layer.borderWidth = 1.0;
    byCategoryBtn.clipsToBounds = YES;
    
}

#pragma mark - Collection view Delegates and Data source
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView != bannerCollectionView) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
      //  UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == bannerCollectionView) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
    } else {
        int width = homeListCollectionView.bounds.size.width/2;
        
       return CGSizeMake(width-10, (CGRectGetHeight(homeListCollectionView.frame)/2)-5);
        
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView == bannerCollectionView) {
        
        return [bannerImagesArray count];
        
    } else {
        return [restoListArray count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == bannerCollectionView) {
        UICollectionViewCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannerID" forIndexPath:indexPath];
         NSDictionary *singleDict = [bannerImagesArray objectAtIndex:indexPath.row];
        /*
         *  UNCOMMENT THE BELOW LINE AND PASS THE IMAGE URL IN THE BELOW LINE
         */
      AsyncImageView *bannerImage = [[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, bannerCell.bounds.size.width, bannerCell.bounds.size.height)];
        dispatch_async(dispatch_get_main_queue(), ^{
            bannerImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_IMAGE_URL,[singleDict valueForKey:@"image"]]];
        });
        
        
      
      
        [bannerCell addSubview:bannerImage];
        return bannerCell;
        
    } else {
        HomeCollectionViewCell*itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
        NSDictionary *singleDict = [restoListArray objectAtIndex:indexPath.row];
        /*
         *  UNCOMMENT THE BELOW LINE AND PASS THE IMAGE URL IN THE BELOW LINE
         */
        dispatch_async(dispatch_get_main_queue(), ^{
           itemCell.cellImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_IMAGE_URL,[singleDict valueForKey:@"bg_img"]]];
        });
        for (UILabel *lab in [itemCell subviews]) {
            if (lab.tag == 100) {
                [lab removeFromSuperview];
            }
        }
        itemCell.offerLabel.numberOfLines = 2;
        itemCell.offerLabel.text = [NSString stringWithFormat:@"%@",[singleDict valueForKey:@"title"]];
        itemCell.numberOfRestaurentsLabel.text = [NSString stringWithFormat:@"(%@ restarents here)",[singleDict valueForKey:@"restos"]];
        return itemCell;
    }
    //
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView != bannerCollectionView) {
        //[self performSegueWithIdentifier:@"homeToDetails" sender:nil];
        NSDictionary *singleDict = [restoListArray objectAtIndex:indexPath.row];
        selectedBottomTab = @"discount";
        ID = [NSString stringWithFormat:@"%d",[[singleDict valueForKey:@"disc_id"]intValue]];
        [self performSegueWithIdentifier:@"homeToMostView" sender:nil];
       

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Next Click
- (IBAction)nextBanerButtonClick:(UIButton *)sender {
    if (bannerCollectionView) {
        if (index < bannerImagesArray.count-1) {
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
//homeToMostView
#pragma mark-textfield Delegates 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"homeToMostView"]) {
         MostViewedViewController *mostVC =segue.destinationViewController;
         mostVC.selectedTabName = selectedBottomTab;
         mostVC.bannerImagesArray = bannerImagesArray;
         mostVC.discountID = ID;
         
     }
 }



#pragma mark- CreatingHorizontalScroll

- (void)createHorozontalScroll:(NSArray *)imagesArray {
    int imageWidth = ([UIScreen mainScreen].bounds.size.width)/2.5;
    
    for (int i = 0; i< imagesArray.count; i++) {
        NSDictionary *singleDict = [horozontalImagesArray objectAtIndex:i];
        AsyncImageView *horzontalImage = [[AsyncImageView alloc]initWithFrame:CGRectMake((i*imageWidth)+10, 4, imageWidth-20,  _horizontalScroll.bounds.size.height-8)];
        dispatch_async(dispatch_get_main_queue(), ^{
           horzontalImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_IMAGE_URL,[singleDict valueForKey:@"images"]]];
            horzontalImage.contentMode = UIViewContentModeScaleAspectFit;
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = horzontalImage.bounds;
            but.tag = i;
            [horzontalImage addSubview:but];
            horzontalImage.userInteractionEnabled = YES;
           [ but addTarget:self action:@selector(offerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        });
        
       
        horzontalImage.contentMode = UIViewContentModeScaleAspectFit;
        [_horizontalScroll addSubview:horzontalImage];
    }
    _horizontalScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width *[imagesArray count]/3, _horizontalScroll.bounds.size.height);
    _horizontalScroll.pagingEnabled = YES;
}

- (void)offerBtnClick:(UIButton *)sender {
    NSDictionary *singleDict = [horozontalImagesArray objectAtIndex:sender.tag];
    selectedBottomTab = @"offer";
    ID = [NSString stringWithFormat:@"%d",[[singleDict valueForKey:@"offerid"]intValue]];
    [self performSegueWithIdentifier:@"homeToMostView" sender:nil] ;
    

}
- (IBAction)costBtnClck:(id)sender {
    LeveyPopListView *lplvCat = [[LeveyPopListView alloc] initWithTitle:(@"Select Price") options:filterPriceModel.PriceArray  handler:^(NSInteger anIndex)
                                 {
                                     [byCostBtn setTitle:[NSString stringWithFormat:@"%@",[filterPriceModel.PriceArray objectAtIndex:anIndex]] forState:UIControlStateNormal];
                                     // _cityTxt.text=[[CityListArray valueForKey:@"city_name"] objectAtIndex:anIndex];
                                     // CityId=[[CityListArray valueForKey:@"city_id"] objectAtIndex:anIndex];
                                 }];
    
    
    
    
    [lplvCat showInView:self.view animated:YES];
}
- (IBAction)categoryBtnClick:(id)sender {
   
    LeveyPopListView *lplvCat = [[LeveyPopListView alloc] initWithTitle:(@"Select Category") options:[filterCategoryModel.categoryArray valueForKey:@"category_name"]  handler:^(NSInteger anIndex)
                              {
                                  [byCategoryBtn setTitle:[NSString stringWithFormat:@"%@",[[filterCategoryModel.categoryArray valueForKey:@"category_name"] objectAtIndex:anIndex]] forState:UIControlStateNormal];
                                 // _cityTxt.text=[[CityListArray valueForKey:@"city_name"] objectAtIndex:anIndex];
                                 // CityId=[[CityListArray valueForKey:@"city_id"] objectAtIndex:anIndex];
                              }];
    
    
    
    
    [lplvCat showInView:self.view animated:YES];
}

- (IBAction)locationBtnClk:(UIButton *)sender {
    
    LeveyPopListView *lplvLoc = [[LeveyPopListView alloc] initWithTitle:(@"Select Location") options:[filterLocationModel.locationArray valueForKey:@"area"]  handler:^(NSInteger anIndex)
                              {
                                  [byLocationBtn setTitle:[NSString stringWithFormat:@"%@",[[filterLocationModel.locationArray valueForKey:@"area"] objectAtIndex:anIndex]] forState:UIControlStateNormal];
                                  // _cityTxt.text=[[CityListArray valueForKey:@"city_name"] objectAtIndex:anIndex];
                                  // CityId=[[CityListArray valueForKey:@"city_id"] objectAtIndex:anIndex];
                              }];
    
    
    
    
    [lplvLoc showInView:self.view animated:YES];
}
@end
