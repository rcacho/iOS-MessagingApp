//
//  MaoViewViewController.h
//  iOS-MessagingApp
//
//  Created by Rich Blanchard on 7/28/15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MessageThread.h"

@interface MaoViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) CLLocation * currentLocation;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) MessageThread * selectedThread;

@end
