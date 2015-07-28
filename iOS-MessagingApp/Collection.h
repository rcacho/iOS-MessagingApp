//
//  Collection.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import "MessageThread.h"

@interface Collection : NSObject

@property MessageThread *thread;

@property NSMutableArray *posts;

- (instancetype)initWithThread:(MessageThread *)thread;

- (void)addPostMessage:(Post *)post;

- (NSInteger)numberOfItemsInSection;

- (Post *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
