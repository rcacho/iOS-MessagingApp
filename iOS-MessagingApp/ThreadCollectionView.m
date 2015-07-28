//
//  ThreadCollectionView.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ThreadCollectionView.h"
#import <Parse/Parse.h>
#import "ThreadViewController.h"
#import "MessageThread.h"
#import "ThreadCell.h"
#import "MockData.h"
#import "CollectionHandler.h"

@interface ThreadCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property CollectionHandler *collection;

@property Collection *selectedThread;

@end

@implementation ThreadCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    // load up mock data
    // cells should be clickable
    // upon clicking a cell go to a threadview
    // threadview is loaded up with topic statement at top
    // message going down (note that we will probably want to order (use date?))
    self.collection = [[CollectionHandler alloc] init];
    self.collection.collectionView = self;
    [self.collection fetchThreads];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showThread"]) {
        [segue.destinationViewController setThread:self.selectedThread];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collection numberOfItemsInSection];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThreadCell *aThreadCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"threadCell" forIndexPath:indexPath];
    aThreadCell.threadForCell = [self.collection itemAtIndexPath:indexPath];
    return aThreadCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedThread = [self.collection itemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showThread" sender:self];

}

- (void)reloadData {
    [self.collectionView reloadData];
}

@end
