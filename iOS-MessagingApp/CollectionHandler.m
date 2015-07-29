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

@interface CollectionHandler ()

@property NSArray *threads;
@property (nonatomic) CLLocation * currentLocation;

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
    PFQuery *query = [PFQuery queryWithClassName:@"MessageThread"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Recieved Data Successfully");
            self.threads = objects;
            [self prepareCollections];
            [self.collectionView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
-(void)addNewThread:(NSString *)topic withLat:(NSNumber *)lat andLong:(NSNumber *)lng andRadius:(NSString *)radius
{
    MessageThread * newThead = [[MessageThread alloc]init];
    newThead.topic = topic;
    newThead.lat = lat;
    newThead.lng = lng;
    float newRadius = [radius floatValue];
    NSNumber * radiusNumber = [NSNumber numberWithFloat:newRadius];
    newThead.radius = radiusNumber;
    newThead.latAndLng = [PFGeoPoint geoPointWithLocation:self.currentLocation];
    [self didAddArray];
    [newThead saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"SUCCEDED");
        }
        else {
            NSLog(@"Fail saving");
        }
        
    }];
    
}
-(void)didAddArray {
    [self fetchThreads];
    [self.collections removeAllObjects];
    [self prepareCollections];
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
