//
//  Group.m
//  iOS Messaging App
//
//  Created by Rich Blanchard on 7/27/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

#import "Group.h"

@implementation Group
- (instancetype)initWithGroupName:(NSString * )groupName andTopic:(NSString *)groupTopic andLocation:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        self.groupTitle = groupName;
        self.groupTopic = groupTopic;
        self.coordinate = coordinate;
    }
    return self;
}

@end
