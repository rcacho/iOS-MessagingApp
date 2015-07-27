//
//  AppDelegate.h
//  iOS Messaging App
//
//  Created by Rich Blanchard on 7/27/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *currentLocation;


@end

