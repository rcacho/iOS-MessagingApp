//
//  Post.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "Post.h"
#import <Parse/PFObject+Subclass.h>

@implementation Post

@dynamic user_id;

@dynamic content;

@dynamic timePosted;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Post";
}


@end
