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
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;

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
    Post * post = self.postForCell;
    PFUser * user = [self.postForCell objectForKey:@"user"];
    NSLog(@"Here is %@",user.username);
    self.posterLabel.text = user.username;
   if(user[@"profilePic"] != nil)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PFFile *userFile = user[@"profilePic"];
            NSData *userPicData = [userFile getData];
            UIImage * image = [UIImage imageWithData:userPicData];
            if(image != nil)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.profilePictureImageView.image = image;
                });
            }
            else {
                self.profilePictureImageView.image = [UIImage imageNamed:@"profile-photo1"];
            }
    
            
        });
    

}

@end
