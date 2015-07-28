//
//  CollectionHandler.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "CollectionHandler.h"
#import <Parse/Parse.h>

@interface CollectionHandler ()

@property NSArray *threads;

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
