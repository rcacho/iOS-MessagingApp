//
//  ThreadViewController.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageThread.h"
#import "Collection.h"
\

@interface ThreadViewController : UIViewController
@property (nonatomic) Collection *thread;

- (void)reloadData;

@end
