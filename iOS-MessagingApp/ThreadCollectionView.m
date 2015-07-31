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

@interface ThreadCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UITextField *groupTopicTextField;

@property (weak, nonatomic) IBOutlet UITextField *groupRadiusTextField;

@property (strong,nonatomic) CLLocation * currentLocation;

@property (strong,nonatomic) NSMutableArray * arrayOfRecentLookedAtPosts;

@property (weak, nonatomic) IBOutlet UITableView *tableViewForRecentLookedAtPosts;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@property CollectionHandler *collection;

@property Collection *selectedThread;

@property (nonatomic) NSInteger currentNumberOfThreadsShown;

@property BOOL shouldIncreaseThreads;

@property CGFloat startingXPanCoordinate;

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


- (void)setCurrentNumberOfThreadsShown:(NSInteger)currentNumberOfThreadsShown {
    if (currentNumberOfThreadsShown >= 0 && currentNumberOfThreadsShown <= [self.collection numberOfItemsInSection]) {
        _currentNumberOfThreadsShown = currentNumberOfThreadsShown;
    } else if (labs(currentNumberOfThreadsShown) == 2) {
        if (_currentNumberOfThreadsShown > currentNumberOfThreadsShown) {
            _currentNumberOfThreadsShown--;
        } else {
            _currentNumberOfThreadsShown++;
        }
    } else {
        for (circleCell *circle in self.collectionView.visibleCells) {
            [circle startJiggle];
        }
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showThread"]) {
        [segue.destinationViewController setThread:self.selectedThread];
    } else if ([segue.identifier isEqualToString:@"createNewGroup"]) {
        [segue.destinationViewController setCollection:self.collection];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.currentNumberOfThreadsShown;
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
- (IBAction)goToCreationPage:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"createNewGroup" sender:sender];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}


- (IBAction)pushThreadIntoView:(UIPanGestureRecognizer *)sender {
    // recognize what direction the pan went
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startingXPanCoordinate = [sender velocityInView:self.view].x;

    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        
        NSString *direction = [self calculateDirection:sender];
        if ([direction isEqualToString:@"left"]) {
            self.shouldIncreaseThreads = NO;
        } else {
            self.shouldIncreaseThreads = YES;
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        NSInteger distance = [self calculateDistance:sender];
        
        if (self.shouldIncreaseThreads) {
             self.currentNumberOfThreadsShown += distance;
        } else  {
            self.currentNumberOfThreadsShown -= distance;
        }
        
        [self.collectionView reloadData];
    }
}

- (NSString *)calculateDirection:(UIPanGestureRecognizer *)recognizer {
    CGPoint velocity = [recognizer velocityInView:self.view];
    if (velocity.x > 0) {
        return @"right";
    }
    
    return @"left";
}

- (NSInteger)calculateDistance:(UIPanGestureRecognizer *)recognizer {
    CGFloat endPoint = [recognizer velocityInView:self.view].x;
    NSInteger distance = fabs(self.startingXPanCoordinate - endPoint);
    if (distance > 400) {
        return 2;
    } else {
        return 1;
    }
}


#pragma mark - TableView for recent posts

#pragma mark - Delegate for looking at a post



@end
