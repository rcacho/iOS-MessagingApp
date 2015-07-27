//
//  GetDistanceViewController.m
//  iOS Messaging App
//
//  Created by Rich Blanchard on 7/27/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

#import "GetDistanceViewController.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "CreateNewGroupViewController.h"

@interface GetDistanceViewController ()  <MKMapViewDelegate,passBackGroup>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *currentLocation;
@property (strong,nonatomic) IBOutlet UITextField * myTextField;
@property float selectedDistance;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation GetDistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.showsUserLocation = true;
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
     self.currentLocation = [[CLLocation alloc] initWithLatitude:appDelegate.currentLocation.coordinate.latitude longitude:appDelegate.currentLocation.coordinate.longitude];
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude);
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1000, 1000);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    
   
    NSLog(@"selected Distance is %f",self.selectedDistance);
    
   
    
    
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter a distance" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * textField) {
        self.myTextField = textField;
        
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        self.selectedDistance = [self.myTextField.text floatValue];
        NSLog(@"selected distance is %f",self.selectedDistance);
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * __nonnull action) {
        //
    }]];
     [self presentViewController:alert animated:YES completion:nil];
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"createGroup"])
    {
        CreateNewGroupViewController * vc = (CreateNewGroupViewController *)segue.destinationViewController;
        vc.locationCoordinate = self.currentLocation.coordinate;
        vc.delegate = self;
        
        
    }
}

- (IBAction)changePage:(id)sender {
    [self performSegueWithIdentifier:@"createGroup" sender:sender];
}
-(void)passBackGroup:(Group *)newGroup
{
     [self.mapView addAnnotation:newGroup];
}


@end
