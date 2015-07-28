//
//  MessageThread.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "MessageThread.h"
#import <Parse/PFObject+Subclass.h>

@implementation MessageThread

@dynamic topic;

@dynamic posts;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"MessageThread";
}



@end
