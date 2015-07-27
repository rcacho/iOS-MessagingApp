//
//  ViewController.m
//  iOS Messaging App
//
//  Created by Rich Blanchard on 7/27/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSString * pictureUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
    }
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.fbPhoto setProfileID:@"user_id"];
    [self.fbPhoto setPictureMode:FBSDKProfilePictureModeSquare];
    [self.view addSubview:self.fbPhoto];
    //FBSDKGraphRequest * request = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:params];
   
    
    if ([FBSDKAccessToken currentAccessToken]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture",@"fields",nil];
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"me"
                                      parameters:params
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result,
                                              NSError *error) {
            NSDictionary * resultsDictionary = [result objectForKey:@"picture"];
            NSDictionary * dataDictionary = resultsDictionary[@"data"];
            NSString * pictureURL = dataDictionary[@"url"];
            self.pictureUrl = pictureURL;
            NSURL * url = [NSURL URLWithString:pictureURL];
            NSData * pictureData = [NSData dataWithContentsOfURL:url];
            UIImage * downloadedImage = [UIImage imageWithData:pictureData];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.profilePictureImageView.image = downloadedImage;
            });
            
            
        }];
        
        
    }

   
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    NSLog(@"user logged out");
    [loginButton setHidden:YES];
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"USER Logged out");
}

@end
