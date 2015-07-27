//
//  PostCell.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-27.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "PostCell.h"

@interface PostCell ()

@property (weak, nonatomic) IBOutlet UILabel *postContentLabel;

@end

@implementation PostCell

- (void)setPostForCell:(Post *)postForCell {
    _postForCell = postForCell;
    [self setContent];
}

- (void)setContent {
    self.postContentLabel.text = self.postForCell.content;
}

@end
