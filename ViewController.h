//
//  ViewController.h
//  iOS Messaging App
//
//  Created by Rich Blanchard on 7/27/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController <FBSDKLoginButtonDelegate> 
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet FBSDKProfilePictureView *fbPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;



@end

