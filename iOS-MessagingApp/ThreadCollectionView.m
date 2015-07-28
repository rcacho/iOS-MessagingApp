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
#import "AppDelegate.h"

@interface ThreadCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) CLLocation * currentLocation;
@property (weak, nonatomic) IBOutlet UITextField *groupTopicTextField;
@property (weak, nonatomic) IBOutlet UITextField *groupRadiusTextField;


@property CollectionHandler *collection;

@property Collection *selectedThread;

@end

@implementation ThreadCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)reloadData {
    [self.collectionView reloadData];
}
- (IBAction)createGroup:(id)sender {
    NSNumber * lat = [NSNumber numberWithFloat:self.currentLocation.coordinate.latitude];
     NSNumber * lng = [NSNumber numberWithFloat:self.currentLocation.coordinate.longitude];
    
    MessageThread * newThread = [[MessageThread alloc]init];
    newThread.topic = self.groupTopicTextField.text;
    float groupRadius = [self.groupTopicTextField.text floatValue];
    NSNumber * radius = [NSNumber numberWithFloat:groupRadius];
    newThread.radius =radius;
    newThread.lat = lat;
    newThread.lng = lng;
    PFGeoPoint * pointForGroup = [PFGeoPoint geoPointWithLocation:self.currentLocation];
    newThread.latAndLng = pointForGroup;
    [newThread saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
}

@end
