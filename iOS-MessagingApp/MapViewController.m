//
//  MaoViewViewController.m
//  iOS-MessagingApp
//
//  Created by Rich Blanchard on 7/28/15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "MapViewController.h"
#import "MessageThread.h"
#import "AppDelegate.h"
#import "MessageThread.h"
#import "CollectionHandler.h"
#import "Collection.h"

@interface MapViewController ()  <MKMapViewDelegate>


@end

@implementation MapViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.mapView.mapType = MKMapTypeHybrid;
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.currentLocation = [[CLLocation alloc] initWithLatitude:appDelegate.currentLocation.coordinate.latitude longitude:appDelegate.currentLocation.coordinate.longitude];
    self.mapView.showsUserLocation = YES;
    
    PFGeoPoint * userGeoPoint = [PFGeoPoint geoPointWithLocation:self.currentLocation];
    PFQuery *query = [PFQuery queryWithClassName:@"MessageThread"];
    [query whereKey:@"latAndLng" nearGeoPoint:userGeoPoint];
   
    
    query.limit = 50;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for(int i =0; i <[objects count];i++)
            {
                MessageThread * currentMessageThread = objects[i];
                CLLocation * groupLocation = [[CLLocation alloc]initWithLatitude:[currentMessageThread.lat floatValue] longitude:[currentMessageThread.lng floatValue]];
                
                CLLocationDistance distanceFromGroup = [self.currentLocation distanceFromLocation:groupLocation];
                if(distanceFromGroup < [currentMessageThread.radius floatValue])
                {
                   
                    MKPointAnnotation * point  = [[MKPointAnnotation alloc] init];
                    point.coordinate = groupLocation.coordinate;
                    point.title = currentMessageThread.topic;
                    point.subtitle = @"I'm here!!!";
                    
                    [self.mapView addAnnotation:point];
                    
                }
            }
           
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}





@end
