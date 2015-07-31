//
//  circleCell.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-28.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "circleCell.h"
#import <QuartzCore/QuartzCore.h>

#define kWiggleBounceY 4.0f
#define kWiggleBounceDuration 0.12
#define kWiggleBounceDurationVariance 0.025

#define kWiggleRotateAngle 0.06f
#define kWiggleRotateDuration 0.1
#define kWiggleRotateDurationVariance 0.025



@interface circleCell ()


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

-(void)startJiggle {
    [UIView animateWithDuration:0
                     animations:^{
                         [self.layer addAnimation:[self rotationAnimation] forKey:@"rotation"];
                         [self.layer addAnimation:[self bounceAnimation] forKey:@"bounce"];
                         self.transform = CGAffineTransformIdentity;
                     }];
}

-(CAAnimation*)rotationAnimation {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.values = @[@(-kWiggleRotateAngle), @(kWiggleRotateAngle)];
    
    animation.autoreverses = YES;
    animation.duration = [self randomizeInterval:kWiggleRotateDuration
                                    withVariance:kWiggleRotateDurationVariance];
    animation.repeatCount = HUGE_VALF;
    
    return animation;
}

-(CAAnimation*)bounceAnimation {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.values = @[@(kWiggleBounceY), @(0.0)];
    
    animation.autoreverses = YES;
    animation.duration = [self randomizeInterval:kWiggleBounceDuration
                                    withVariance:kWiggleBounceDurationVariance];
    animation.repeatCount = HUGE_VALF;
    
    return animation;
}

-(NSTimeInterval)randomizeInterval:(NSTimeInterval)interval withVariance:(double)variance {
    double random = (arc4random_uniform(1000) - 500.0) / 500.0;
    return interval + variance * random;
}

@end
