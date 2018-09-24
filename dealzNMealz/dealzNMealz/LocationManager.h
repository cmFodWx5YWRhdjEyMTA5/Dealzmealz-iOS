//
//  LocationManager.h
//  dealzNMealz
//
//  Created by siva sandeep on 22/09/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject
@property  CLLocationManager *locationManager;
+ (instancetype)sharedInstance;

@end
