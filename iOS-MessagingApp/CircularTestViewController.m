//
//  CircularTestViewController.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-28.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "CircularTestViewController.h"
#import "circleCell.h"
#import "CircularLayout.h"
#import "Collection.h"
#import "CollectionHandler.h"

@interface CircularTestViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property CollectionHandler *collection;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@property Collection *selectedCollection;

@end

@implementation CircularTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collection = [[CollectionHandler alloc] init];
    self.collection.collectionView = self;
    [self.collection fetchThreads];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collection numberOfItemsInSection];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.collection numberOfItemsInSection];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    circleCell *circleCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"circleCell" forIndexPath:indexPath];
    return circleCell;
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCollection = [self.collection itemAtIndexPath:indexPath];
    [self setTopicText];
}

- (void)setTopicText {
    self.topicLabel.text = self.selectedCollection.thread.topic;
}

@end
