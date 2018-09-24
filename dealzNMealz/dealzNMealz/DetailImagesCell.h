//
//  DetailImagesCell.h
//  dealzNMealz
//
//  Created by siva sandeep on 12/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailImagesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *detailImagesScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pagControl;

@end
