//
//  Post.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property NSString *user_id;

@property NSString *content;

@property NSDate *timePosted;


- (instancetype)initWithUserID:(NSString *)userID andContent:(NSString *)content;

@end

