//
//  ThreadCollectionView.h
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ThreadCollectionView : UIViewController 

// this probably should be left up to some delegate rather than this strategy
- (void)reloadData;


@end
