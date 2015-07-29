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

@interface ThreadCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *groupTopicTextField;
@property (weak, nonatomic) IBOutlet UITextField *groupRadiusTextField;
@property (strong,nonatomic) CLLocation * currentLocation;


@property CollectionHandler *collection;

@property Collection *selectedThread;

@end

@implementation ThreadCollectionView


- (void)viewDidLoad {
    [super viewDidLoad];
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
    circleCell *aThreadCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"threadCell" forIndexPath:indexPath];
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
     if([self checkIfEntry:self.groupTopicTextField] != 0 && [self checkIfNumber:self.groupRadiusTextField] != 0 )
     {
         [self.collection addNewThread:self.groupTopicTextField.text withLat:lat andLong:lng andRadius:self.groupRadiusTextField.text];
     }
    
}
    -(BOOL)checkIfEntry:(UITextField *)textfield
{
    if(textfield.text != nil)
    {
        return YES;
    }
    else {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Please Enter text" message:@"Your text is empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
}
-(BOOL)checkIfNumber:(UITextField *)textfield
{
    NSString * txtString = [textfield text];
    NSInteger radiusInt = [txtString integerValue];
    if(radiusInt != 0)
    {
        return YES;
    }
    else {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Please Enter a number" message:@"Your did not enter a valid number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
}
@end
