//
//  CollectionHandler.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThreadCollectionView.h"
#import "Collection.h"
#import "MessageThread.h"

@interface CollectionHandler : NSObject

@property NSMutableArray *collections;

@property ThreadCollectionView *collectionView;

- (void)fetchThreads;

- (NSInteger)numberOfItemsInSection;

- (Collection *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
