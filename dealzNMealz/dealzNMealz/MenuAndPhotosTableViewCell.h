//
//  MenuAndPhotosTableViewCell.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/6/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuAndPhotosTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *menuImagesScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *photosScrollView;
@end
