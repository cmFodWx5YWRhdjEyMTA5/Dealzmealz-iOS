//
//  Utils.m
//  dealzNMealz
//
//  Created by siva sandeep on 16/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIImage *)getImageFromLat:(CGFloat)latitude andLong:(CGFloat)longitude {
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"https://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@",latitude, longitude,@"zoom=16&size=100x100"];
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    return image;
}

+ (NSString *)getMapImageUrlWithLat:(CGFloat)latitude andLong:(CGFloat)longitude {
    NSString *staticMapUrl = [NSString stringWithFormat:@"https://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@&sensor=true",latitude, longitude,@"zoom=16&size=100x100"];
    return staticMapUrl;
}
@end
