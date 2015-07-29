
//
//  ThreadCell.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ThreadCell.h"

@interface ThreadCell ()

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@end

@implementation ThreadCell

- (void)setThreadForCell:(Collection *)threadForCell {
    _threadForCell = threadForCell;
    [self setContent];
}

- (void)setContent {
    self.topicLabel.text = self.threadForCell.thread.topic;
    
}

@end
