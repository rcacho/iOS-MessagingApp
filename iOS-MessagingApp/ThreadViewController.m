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

@interface ThreadViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *headerBubbleView;


@property UITextField *activeTextField;

@property NSMutableDictionary *posts;

@property NSString *userNewPostContent;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    self.thread.tableView = self;
    [self.thread fetchThreadPosts];
    
    self.topicLabel.text = self.thread.thread.topic;
    
    self.posts = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.thread.posts, @"posts", nil];
    
    self.headerBubbleView.layer.cornerRadius = self.headerBubbleView.frame.size.height /2;
    self.headerBubbleView.layer.masksToBounds = YES;
    self.headerBubbleView.layer.borderWidth = 0.1;
}

- (void)setThread:(Collection *)thread {
    _thread = thread;
    [self setContent];
}

- (void)setContent {
    self.topicLabel.text = self.thread.thread.topic;
}

#pragma mark - TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.thread numberOfItemsInSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *aPostCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    aPostCell.postForCell = [self.thread itemAtIndexPath:indexPath];
    return aPostCell;
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.userNewPostContent = textField.text;
     [self createNewpost];
    [self.tableView reloadData];
    
    self.activeTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark - ScrollView Delegate


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeTextField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


#pragma mark - Create New Post

- (void)createNewpost {
    // create new post add it to self
    // in the real version we would likely add it to our db as well as send it off
    
    // don't yet have anything to take the user-ID from...
    Post *postToBeAdded = [[Post alloc] init];
    postToBeAdded.user_id = @"1";
    postToBeAdded.content = self.userNewPostContent;
    
    [self.thread addPostMessage:postToBeAdded];
}

@end
