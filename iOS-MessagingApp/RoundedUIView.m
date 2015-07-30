//
//  RoundedUIView.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-29.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "RoundedUIView.h"

@implementation RoundedUIView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
}

@end
