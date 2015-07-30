//
//  ThreadCreationViewController.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-29.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MessageThread.h"
#import "CollectionHandler.h"

@interface ThreadCreationViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong,nonatomic) CLLocation * currentLocation;

@property (strong,nonatomic) CLLocationManager *locationManager;

@property (strong,nonatomic) CollectionHandler * collection;

@end
