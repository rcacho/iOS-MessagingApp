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
#import "CollectionHandler.h"
#import "AppDelegate.h"
#import "circleCell.h"

@interface ThreadCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UITextField *groupTopicTextField;

@property (weak, nonatomic) IBOutlet UITextField *groupRadiusTextField;

@property (strong,nonatomic) CLLocation * currentLocation;
@property (strong,nonatomic) NSMutableArray * arrayOfRecentLookedAtPosts;
@property (weak, nonatomic) IBOutlet UITableView *tableViewForRecentLookedAtPosts;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@property CollectionHandler *collection;

@property Collection *selectedThread;

@end

@implementation ThreadCollectionView



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewForRecentLookedAtPosts.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(62.0/255.0) blue:(78/255.0) alpha:1.0];
    [self.navigationItem setHidesBackButton:YES];

    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.currentLocation = [[CLLocation alloc] initWithLatitude:appDelegate.currentLocation.coordinate.latitude longitude:appDelegate.currentLocation.coordinate.longitude];
    // load up mock data
    // cells should be clickable
    // upon clicking a cell go to a threadview
    // threadview is loaded up with topic statement at top
    // message going down (note that we will probably want to order (use date?))
    self.collection = [[CollectionHandler alloc] init];
    self.collection.collectionView = self;
    [self.collection fetchThreads];
    [self.navigationItem setHidesBackButton:YES];
    

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showThread"]) {
        
        [segue.destinationViewController setThread:self.selectedThread];
        
    }
  else if ([segue.identifier isEqualToString:@"createNewGroup"]) {
        [segue.destinationViewController setCollection:self.collection];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collection numberOfItemsInSection];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    circleCell *aThreadCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"threadCell" forIndexPath:indexPath];
    return aThreadCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedThread = [self.collection itemAtIndexPath:indexPath];
    
    self.topicLabel.text = [self.collection itemAtIndexPath:indexPath].thread.topic;
    
    [self performSegueWithIdentifier:@"showThread" sender:self];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)reloadData {
   
         [self.collectionView reloadData];
   
}

#pragma mark - TableView for recent posts

#pragma mark - Delegate for looking at a post


- (IBAction)goToCreationPage:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"createNewGroup" sender:sender];
}










@end
