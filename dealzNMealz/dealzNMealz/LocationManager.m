//
//  LocationManager.m
//  dealzNMealz
//
//  Created by siva sandeep on 22/09/18.
//  Copyright © 2018 Ameet Sangamkar. All rights reserved.
//

#import "LocationManager.h"
@implementation LocationManager
    
+ (instancetype)sharedInstance {
    static LocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationManager alloc] init];
    });
    return sharedInstance;
}
-(instancetype)init{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [_locationManager startUpdatingLocation];
    return self;
}

@end
