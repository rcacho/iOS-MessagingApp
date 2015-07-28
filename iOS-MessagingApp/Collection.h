//
//  Collection.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ThreadViewController;
#import "Post.h"
#import "MessageThread.h"

@interface Collection : NSObject

@property MessageThread *thread;

@property NSMutableArray *posts;

@property ThreadViewController *tableView;

- (instancetype)initWithThread:(MessageThread *)thread;

- (void)addPostMessage:(Post *)post;

- (void)fetchThreadPosts;

- (NSInteger)numberOfItemsInSection;

- (Post *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
