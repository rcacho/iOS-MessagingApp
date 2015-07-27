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

@implementation MockData

+ (NSDictionary *)getMockData {
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:@[[MockData firstThread], [MockData secondThread]],@"first", nil];
    return data;
}

+ (MessageThread *)firstThread {
    MessageThread *firstThread = [[MessageThread alloc] initWithTopic:@"Need Players For BasetBall Game"];
    Post *firstPost = [[Post alloc] initWithUserID:@"0" andContent:@"ok"];
    Post *secondPost = [[Post alloc] initWithUserID:@"0" andContent:@"sure"];
    Post *thirdPost = [[Post alloc] initWithUserID:@"0" andContent:@"be there soon"];
    
    [firstThread.posts addObject:firstPost];
    [firstThread.posts addObject:secondPost];
    [firstThread.posts addObject:thirdPost];
    
    return firstThread;
}

+ (MessageThread *)secondThread {
    MessageThread *firstThread = [[MessageThread alloc] initWithTopic:@"stuck in traffic over here"];
    Post *firstPost = [[Post alloc] initWithUserID:@"0" andContent:@"ok"];
    Post *secondPost = [[Post alloc] initWithUserID:@"0" andContent:@"sure"];
    Post *thirdPost = [[Post alloc] initWithUserID:@"0" andContent:@"be there soon"];
    
    [firstThread.posts addObject:firstPost];
    [firstThread.posts addObject:secondPost];
    [firstThread.posts addObject:thirdPost];
    
    return firstThread;
}

@end
