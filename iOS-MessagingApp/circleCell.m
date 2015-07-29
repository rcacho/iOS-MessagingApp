//
//  circleCell.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-28.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "circleCell.h"
#import <QuartzCore/QuartzCore.h>

@interface circleCell ()

@property (weak, nonatomic) IBOutlet UIView *view;

@end

@implementation circleCell



-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    self.view.layer.cornerRadius = self.view.frame.size.height /2;
//    self.view.layer.masksToBounds = YES;
//    self.view.layer.borderWidth = 0.1;
    
    self.layer.cornerRadius = self.frame.size.height /2.0;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.1;
    
}

- (void)prepareForReuse {

}

@end
