//
//  DetailTitleCell.h
//  dealzNMealz
//
//  Created by siva sandeep on 12/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *restoTitle;
@property (weak, nonatomic) IBOutlet UILabel *restoOpenStatus;
@property (weak, nonatomic) IBOutlet UILabel *restoMorningTimesLbl;
@property (weak, nonatomic) IBOutlet UILabel *restoEveTimingsLbl;
@property (weak, nonatomic) IBOutlet UILabel *restoRatingsLbl;

@end
