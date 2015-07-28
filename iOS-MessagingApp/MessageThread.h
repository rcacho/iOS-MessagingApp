//
//  MessageThread.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface MessageThread : PFObject <PFSubclassing>

@property NSString *topic;
@property PFGeoPoint * latAndLng;
@property NSNumber * radius;
@property NSNumber * lat;
@property NSNumber * lng;

@property NSMutableArray *posts;

@end
