//
//  CreateNewGroupViewController.h
//  iOS Messaging App
//
//  Created by Rich Blanchard on 7/27/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Group.h"
@protocol passBackGroup <NSObject>
-(void)passBackGroup:(Group *)newGroup;
@end
@interface CreateNewGroupViewController : ViewController

@property (weak, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *groupTopicTextField;
@property (nonatomic) CLLocationCoordinate2D  locationCoordinate;
@property id<passBackGroup> delegate;

@end
