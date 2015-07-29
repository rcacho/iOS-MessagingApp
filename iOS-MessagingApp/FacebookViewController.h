//
//  FacebookViewController.h
//  iOS-MessagingApp
//
//  Created by Rich Blanchard on 7/28/15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>

@interface FacebookViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end
