//
//  HomeCollectionViewCell.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/2/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBackGroundView;

@property (weak, nonatomic) IBOutlet AsyncImageView *cellImage;
@property (weak, nonatomic) IBOutlet UIImageView *cellDiscountImage;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *offerLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfRestaurentsLabel;
@end
