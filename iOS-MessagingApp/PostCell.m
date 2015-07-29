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
@property (weak, nonatomic) IBOutlet UILabel *posterLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation PostCell

- (void)setPostForCell:(Post *)postForCell {
    _postForCell = postForCell;
    [self setContent];
}

- (void)setContent {
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.postForCell.timePosted
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    
    self.timeLabel.text = dateString;
    self.postContentLabel.text = self.postForCell.content;
    PFUser * user = self.postForCell[@"user"];
    NSString * username = user.username;
    self.posterLabel.text = username;
}

@end
