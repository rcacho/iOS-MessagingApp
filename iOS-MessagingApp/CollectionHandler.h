//
//  CollectionHandler.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThreadCollectionView.h"
#import "CircularTestViewController.h"
#import "Collection.h"
#import "MessageThread.h"

@interface CollectionHandler : NSObject

@property NSMutableArray *collections;

@property  CircularTestViewController *collectionView;

- (void)fetchThreads;

- (NSInteger)numberOfItemsInSection;

- (Collection *)itemAtIndexPath:(NSIndexPath *)indexPath;

-(void)addNewThread:(NSString *)topic withLat:(NSNumber *)lat andLong:(NSNumber *)lng andRadius:(NSNumber *)radius andPost:(NSString *)content;

@end
