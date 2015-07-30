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

@property MKCircleView *areaOfMessage;

@end

@implementation ThreadCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.mapView.showsUserLocation = true;

    
}


- (void) initiateMap {
    LocationManagerHandler *theLocationManagerHandler = [LocationManagerHandler defaultLocationManagerHandler];
    
    
    
    _currentLocation = [[CLLocation alloc] initWithLatitude:theLocationManagerHandler.currentLocation.coordinate.latitude longitude:theLocationManagerHandler.currentLocation.coordinate.longitude];
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude - 0.0075, _currentLocation.coordinate.longitude - 0.0008);
    
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    [self addCircle:150];

    

    
}

- (void)addCircle:(NSInteger)radius {
    CLLocationCoordinate2D center = {_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude};
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:radius];
    [self.mapView addOverlay:circle];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    self.areaOfMessage = [[MKCircleView alloc] initWithOverlay:overlay];
    [self.areaOfMessage setFillColor:[UIColor redColor]];
    [self.areaOfMessage setAlpha:0.5f];
    return self.areaOfMessage;
}

-(void)mapViewDidFinishLoadingMap:(nonnull MKMapView *)mapView{

        [self initiateMap];
}


- (IBAction)submitNewGroup:(UIButton *)sender {
    
}


- (IBAction)expandArea:(UISlider *)sender {
    [self.mapView removeOverlay:self.areaOfMessage.circle];
    [self addCircle:sender.value * 100];
    
}


@end
