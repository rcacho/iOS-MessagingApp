//
//  TestMapControlller.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-28.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "TestMapControlller.h"
#import <MapKit/MapKit.h>
#import "LocationManagerHandler.h"
#import "CollectionHandler.h"
#import "Collection.h"
#import "circleCell.h"

#define zoominMapArea 2100

@interface TestMapControlller () <MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong,nonatomic) CLLocation *currentLocation;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property CollectionHandler *collection;

@property Collection *selectedCollection;

@end

@implementation TestMapControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collection = [[CollectionHandler alloc] init];
    self.collection.collectionView = self;
    [self.collection fetchThreads];
}


- (void) initiateMap {
    [self.mapView setShowsUserLocation:YES];
    LocationManagerHandler *theLocationHandler =[LocationManagerHandler defaultLocationManagerHandler];
    
    _currentLocation = [[CLLocation alloc] initWithLatitude:theLocationHandler.currentLocation.coordinate.latitude longitude:theLocationHandler.currentLocation.coordinate.longitude];
    
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude);
    
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    

    
}

-(void)mapViewDidFinishLoadingMap:(nonnull MKMapView *)mapView{

        [self initiateMap];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collection numberOfItemsInSection];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.collection numberOfItemsInSection];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    circleCell *circleCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"circleCell" forIndexPath:indexPath];
    return circleCell;
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCollection = [self.collection itemAtIndexPath:indexPath];

}

@end
