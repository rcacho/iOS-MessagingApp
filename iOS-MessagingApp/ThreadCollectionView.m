//
//  ThreadCollectionView.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ThreadCollectionView.h"
#import "ThreadCell.h"

@interface ThreadCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSDictionary *threads;

@end

@implementation ThreadCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    // load up mock data
    // cells should be clickable
    // upon clicking a cell go to a threadview
    // threadview is loaded up with topic statement at top
    // message going down (note that we will probably want to order (use date?))
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.threads.allValues[section] count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThreadCell *aThreadCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"threadCell" forIndexPath:indexPath];
    return aThreadCell;
}


@end
