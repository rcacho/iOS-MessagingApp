//
//  CollectionHandler.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "CollectionHandler.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerHandler.h"

@interface CollectionHandler ()

@property NSArray *threads;

@property (nonatomic) CLLocation * currentLocation;
@property (nonatomic,strong) NSMutableArray * closeLocationsToAdd;
@property double radiusInKm;

@end

@implementation CollectionHandler

- (instancetype)init {
    self = [super init];
    if (self) {
       
        _collections = [[NSMutableArray alloc] init];
           }
    return self;
}

- (void)fetchThreads {
     LocationManagerHandler *theLocationManagerHandler = [LocationManagerHandler defaultLocationManagerHandler];
    _currentLocation = [[CLLocation alloc] initWithLatitude:theLocationManagerHandler.currentLocation.coordinate.latitude longitude:theLocationManagerHandler.currentLocation.coordinate.longitude];
    
    PFQuery *query = [PFQuery queryWithClassName:@"MessageThread"];
    
    PFGeoPoint * point = [PFGeoPoint geoPointWithLocation:self.currentLocation];
    [query whereKey:@"latAndLng" nearGeoPoint:point];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error)
     {
          NSMutableArray * tempArray = [[NSMutableArray alloc]init];
         for(int i =0;i< [objects count]; i++)
         {
         MessageThread * closeThread = objects[i];
         double distanceInKm = [point distanceInKilometersTo:closeThread.latAndLng];
         double distanceInM = distanceInKm / 1000;
         NSNumber * distanceInMNsNumber = [NSNumber numberWithFloat:distanceInM];
            
             if(distanceInMNsNumber < closeThread.radius)
             {
                 [tempArray addObject:closeThread];
                 
             }
         
         }
         self.threads = tempArray;
         [self prepareCollections];
         [self.collectionView reloadData];

         
     }];
}

-(void)addNewThread:(NSString *)topic withLat:(NSNumber *)lat andLong:(NSNumber *)lng andRadius:(NSNumber *)radius andImage:(UIImage *)image andPost:(NSString *)content
{
    MessageThread * newThead = [[MessageThread alloc]init];
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"Profileimage.png" data:imageData];
    newThead.image = imageFile;
    newThead.topic = topic;
    newThead.lat = lat;
    newThead.lng = lng;
    newThead.radius = radius;
    newThead.latAndLng = [PFGeoPoint geoPointWithLocation:self.currentLocation];
    [self didAddArray];
    [newThead saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"SUCCEDED");

            if (content != nil) {
                Collection *newestCollection = [[Collection alloc] initWithThread:newThead];
                Post *firstPost = [[Post alloc] init];
                firstPost.content = content;
                [newestCollection addPostMessage:firstPost];
            }

        }
        else {
            NSLog(@"Fail saving");
        }
        
    }];
    
}
-(void)didAddArray {
    [self.collections removeAllObjects];
    [self fetchThreads];
   }

- (void)prepareCollections {
    for (MessageThread *thread in self.threads) {
        Collection *collection = [[Collection alloc] initWithThread:thread];
        [self.collections addObject:collection];
    }
}

- (NSInteger)numberOfItemsInSection{
    return self.collections.count;
}

- (Collection *)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collections[indexPath.row];
}


@end
