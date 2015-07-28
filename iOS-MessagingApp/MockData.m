//
//  MockData.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "MockData.h"
#import "MessageThread.h"
#import "Post.h"
#import "Collection.h"

@implementation MockData

+ (NSDictionary *)getMockData {
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:@[[MockData firstThread], [MockData secondThread]],@"first", nil];
    return data;
}

+ (Collection *)firstThread {
    MessageThread *firstThread = [[MessageThread alloc] init];
    firstThread.topic = @"we need players for a basketball game";
    Post *firstPost = [[Post alloc] init];
    firstPost.user_id = @"0";
    firstPost.content = @"okay";
    firstPost.timePosted = [NSDate date];
    
    Post *secondPost = [[Post alloc] init];
    secondPost.user_id = @"0";
    secondPost.content = @"sure";
    secondPost.timePosted = [NSDate date];
    
    Post *thirdPost = [[Post alloc] init];
    thirdPost.user_id = @"0";
    thirdPost.content = @"be right there";
    thirdPost.timePosted = [NSDate date];
    
    [firstThread.posts addObject:firstPost];
    [firstThread.posts addObject:secondPost];
    [firstThread.posts addObject:thirdPost];
    
    [firstPost setObject:firstThread forKey:@"createdBy"];
    [secondPost setObject:firstThread forKey:@"createdBy"];
    [thirdPost setObject:firstThread forKey:@"createdBy"];
    
    [firstPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
    
    Collection *collection = [[Collection alloc] initWithThread:firstThread];
    [collection addPostMessage:firstPost];
    [collection addPostMessage:secondPost];
    [collection addPostMessage:thirdPost];
    
    
    [secondPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
    
    [thirdPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
    
    [firstThread saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
    
    return collection;
}

+ (Collection*)secondThread {
    
    MessageThread *firstThread = [[MessageThread alloc] init];
    firstThread.topic = @"Stuck in traffic";
    
    Post *firstPost = [[Post alloc] init];
    firstPost.user_id = @"0";
    firstPost.content = @"okay";
    firstPost.timePosted = [NSDate date];
    
    Post *secondPost = [[Post alloc] init];
    secondPost.user_id = @"0";
    secondPost.content = @"sure";
    secondPost.timePosted = [NSDate date];
    
    Post *thirdPost = [[Post alloc] init];
    thirdPost.user_id = @"0";
    thirdPost.content = @"be right there";
    thirdPost.timePosted = [NSDate date];
    
    Collection *collection = [[Collection alloc] initWithThread:firstThread];
    [collection addPostMessage:firstPost];
    [collection addPostMessage:secondPost];
    [collection addPostMessage:thirdPost];
    
    
    
    [firstPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
    
    
    [secondPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
    
    [thirdPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];

    
    [firstThread saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
    return collection;
}

@end
