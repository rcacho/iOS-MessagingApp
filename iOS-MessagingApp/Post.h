//
//  Post.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface Post : PFObject <PFSubclassing>

@property NSString *user_id;

@property NSString *content;

@property NSDate *timePosted;

@end

