//
//  ThreadViewController.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ThreadViewController.h"
#import "PostCell.h"

@interface ThreadViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSDictionary *posts;

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts.allValues[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *aPostCell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    
    return aPostCell;
}

@end
