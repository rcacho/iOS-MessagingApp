//
//  Collection.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "Collection.h"

@implementation Collection

- (instancetype)initWithThread:(MessageThread *)thread {
    self = [super init];
    if (self) {
        _thread = thread;
        _posts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addPostMessage:(Post *)post {
    [self.posts addObject:post];
    [post setObject:self.thread forKey:@"createdBy"];
}

@end
