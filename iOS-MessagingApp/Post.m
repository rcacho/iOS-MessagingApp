//
//  Post.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype)initWithUserID:(NSString *)userID andContent:(NSString *)content {
    self = [super init];
    if (self) {
        _user_id = userID;
        _content = content;
        _timePosted = [NSDate date];
    }
    return self;
}

@end
