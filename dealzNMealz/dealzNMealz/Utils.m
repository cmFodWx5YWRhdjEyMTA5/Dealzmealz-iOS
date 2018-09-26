//
//  Utils.m
//  dealzNMealz
//
//  Created by siva sandeep on 16/08/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import "Utils.h"
#import "URLList.h"
@implementation Utils

+ (UIImage *)getImageFromLat:(CGFloat)latitude andLong:(CGFloat)longitude {
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"https://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@&key=%@",latitude, longitude,@"zoom=16&size=100x100",GOOGLEAPIKEY];
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    return image;
}

+ (NSString *)getMapImageUrlWithLat:(CGFloat)latitude andLong:(CGFloat)longitude {
    NSString *staticMapUrl = [NSString stringWithFormat:@"https://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@&sensor=true&key=%@",latitude, longitude,@"zoom=16&size=100x100",GOOGLEAPIKEY];
    return staticMapUrl;
}
@end
