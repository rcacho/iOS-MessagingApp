//
//  Collection.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "Collection.h"
#import "ThreadViewController.h"

@implementation Collection

- (instancetype)initWithThread:(MessageThread *)thread {
    self = [super init];
    if (self) {
        _thread = thread;
        _posts = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Parse Methods

- (void)fetchThreadPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"createdBy" equalTo:self.thread];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Recieved Data Successfully");
            [self preparePosts:(NSArray *)objects];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)preparePosts:(NSArray *)posts {
    for (Post *post in posts) {
        [self.posts addObject:post];
    }
}

- (void)addPostMessage:(Post *)post {
    [self.posts addObject:post];
    [post setObject:self.thread forKey:@"createdBy"];
    [self save:post];
}

- (void)save:(Post *)aPost {
    [aPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
        } else {
            NSLog(@"failure");
        }
    }];
}

#pragma mark - Collection Methods

- (NSInteger)numberOfItemsInSection {
    return self.posts.count;
}

- (Post *)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.posts[indexPath.row];
}


@end
