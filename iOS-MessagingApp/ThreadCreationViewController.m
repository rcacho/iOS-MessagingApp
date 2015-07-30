//
//  ThreadCreationViewController.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-29.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ThreadCreationViewController.h"
#import "LocationManagerHandler.h"

#define zoominMapArea 2100

@interface ThreadCreationViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *topicTextField;

@property (weak, nonatomic) IBOutlet UITextField *postTextField;

@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;

@end

@implementation ThreadCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.mapView.showsUserLocation = true;
    
}


- (void) initiateMap {
    LocationManagerHandler *theLocationManagerHandler = [LocationManagerHandler defaultLocationManagerHandler];
    
    
    
    _currentLocation = [[CLLocation alloc] initWithLatitude:theLocationManagerHandler.currentLocation.coordinate.latitude longitude:theLocationManagerHandler.currentLocation.coordinate.longitude];
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude);
    
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    

    
}

-(void)mapViewDidFinishLoadingMap:(nonnull MKMapView *)mapView{

        [self initiateMap];
}


- (IBAction)submitNewGroup:(UIButton *)sender {
}

@end
