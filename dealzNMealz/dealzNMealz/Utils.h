//
//  Utils.h
//  dealzNMealz
//
//  Created by siva sandeep on 16/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utils : NSObject
+(UIImage* )getImageFromLat:(CGFloat)latitude andLong:(CGFloat)longitude;
+ (NSString *)getMapImageUrlWithLat:(CGFloat)latitude andLong:(CGFloat)longitude;
@end
