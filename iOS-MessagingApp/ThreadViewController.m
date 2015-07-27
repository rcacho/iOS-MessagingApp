//
//  ThreadViewController.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ThreadViewController.h"
#import "Post.h"
#import "PostCell.h"

@interface ThreadViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableDictionary *posts;

@property NSString *userNewPostContent;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topicLabel.text = self.thread.topic;
    
    self.posts = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.thread.posts, @"posts", nil];
}

- (void)setThread:(MessageThread *)thread {
    _thread = thread;
    [self setContent];
}

- (void)setContent {
    self.topicLabel.text = self.thread.topic;
}

#pragma mark - TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts.allValues[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *aPostCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    aPostCell.postForCell = self.posts.allValues[indexPath.section][indexPath.row];
    return aPostCell;
}

#pragma mark - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:textField cache:YES];
    textField.frame = CGRectMake(10, 50, 300, 200);
    [UIView commitAnimations];
    
    NSLog(@"Started editing target!");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.userNewPostContent = textField.text;
     [self createNewpost];
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)createNewpost {
    // create new post add it to self
    // in the real version we would likely add it to our db as well as send it off
    
    // don't yet have anything to take the user-ID from...
    Post *postToBeAdded = [[Post alloc] initWithUserID:@"0" andContent:self.userNewPostContent];
    [self.posts.allValues[0] addObject:postToBeAdded];
    
    
}

@end
