//
//  CircularLayout.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-28.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "CircularLayout.h"

#define ITEM_SIZE (CGFloat 70);

@implementation CircularLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGSize size = self.collectionView.frame.size;// what is this suppose to be then?? Perhaps it should be collectionView?
    
    if ([self.collectionView numberOfSections] > 0) {
        _cellCount =  [self.collectionView numberOfItemsInSection:0];
    } else {
        _cellCount = 0;
    }
    
    _center = CGPointMake(size.width / 2.0, size.height /2.0);
    _radius = MIN(size.width, size.height) / 2.5;
    
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    layoutAttributes.size = CGSizeMake(30, 30); // is the const not being set up correctly??
    layoutAttributes.center = CGPointMake(_center.x + _radius * cosf(2 * indexPath.item * M_PI / _cellCount),
                                          _center.y + _radius * sinf(2 * indexPath.item * M_PI / _cellCount));
    
    return layoutAttributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    for (int i = 0; i < self.cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [layoutAttributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return layoutAttributes;
}



@end
