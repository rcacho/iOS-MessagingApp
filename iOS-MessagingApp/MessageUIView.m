//
//  MessageUIView.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-29.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "MessageUIView.h"

@implementation MessageUIView

- (void)drawRect:(CGRect)rect {
    //[super drawRect:rect];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, .5f);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetRGBFillColor(context, 255/255, 62/255, 78/255, 0.7);
    
    rect.origin.y++;
    CGFloat radius = self.layer.cornerRadius;
    
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    
    CGMutablePathRef outlinePath = CGPathCreateMutable();
    
        minx += 5;
        
    CGPathMoveToPoint(outlinePath, nil, midx, miny);
    CGPathAddArcToPoint(outlinePath, nil, maxx, miny, maxx, midy, radius);
    CGPathAddArcToPoint(outlinePath, nil, maxx, maxy, midx, maxy, radius);
    CGPathAddArcToPoint(outlinePath, nil, minx, maxy, minx, midy, radius);
    CGPathAddLineToPoint(outlinePath, nil, minx, miny + 20);
    CGPathAddLineToPoint(outlinePath, nil, minx - 5, miny + 15);
    CGPathAddLineToPoint(outlinePath, nil, minx, miny + 10);
    CGPathAddArcToPoint(outlinePath, nil, minx, miny, midx, miny, radius);
    CGPathCloseSubpath(outlinePath);
    
    CGContextAddPath(context, outlinePath);
    CGContextFillPath(context);
    
    CGContextAddPath(context, outlinePath);
    CGContextClip(context);

    //self.backgroundColor = [UIColor colorWithRed:255 green:62 blue:78 alpha:0.8];
    
    
 
    
}

@end
