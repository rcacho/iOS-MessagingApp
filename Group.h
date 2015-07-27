//
//  Group.h
//  iOS Messaging App
//
//  Created by Rich Blanchard on 7/27/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Group : NSObject <MKAnnotation>
@property (nonatomic,strong) NSString * groupTitle;
@property (nonatomic,strong) NSString * groupTopic;
@property (nonatomic) CLLocationCoordinate2D coordinate;
- (instancetype)initWithGroupName:(NSString * )groupName andTopic:(NSString *)groupTopic andLocation:(CLLocationCoordinate2D)coordinate;


@end
