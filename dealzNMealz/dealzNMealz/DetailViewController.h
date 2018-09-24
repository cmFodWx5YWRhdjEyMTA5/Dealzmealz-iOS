//
//  DetailViewController.h
//  dealzNMealz
//
//  Created by Ameet Sangamkar on 9/3/17.
//  Copyright © 2017 Ameet Sangamkar. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *detailsImage;

@property (strong, nonatomic) IBOutlet UIView *detailsImageBackGroundView;
@end
