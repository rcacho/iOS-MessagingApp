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
@protocol lookedAtPost <NSObject>
-(void)lookedAtPost:(Collection *)lookedAtCollection;
@end

@interface ThreadViewController : UIViewController
@property (nonatomic) Collection *thread;
@property id<lookedAtPost> delegate;

- (void)reloadData;

@end
