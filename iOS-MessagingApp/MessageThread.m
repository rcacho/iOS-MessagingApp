//
//  MessageThread.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "MessageThread.h"

@implementation MessageThread

- (instancetype)initWithTopic:(NSString *)topic {
    self = [super init];
    if (self) {
        _topic = topic;
        _posts = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
