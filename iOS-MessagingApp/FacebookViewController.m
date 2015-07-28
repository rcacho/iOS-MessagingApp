//
//  FacebookViewController.m
//  iOS-MessagingApp
//
//  Created by Rich Blanchard on 7/28/15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "FacebookViewController.h"


@interface FacebookViewController () <FBSDKLoginButtonDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSString * pictureUrl;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSData * dataForPicture;

@end

@implementation FacebookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    if ([FBSDKAccessToken currentAccessToken] && [PFUser currentUser]) {
        NSLog(@"WE ARE LOGGED in");
        
    }
    
    else {
        self.loginButton = [[FBSDKLoginButton alloc] init];
        self.loginButton.delegate = self;
        self.loginButton.delegate = self;
        self.loginButton.center = self.view.center;
        [self.view addSubview:self.loginButton];
        self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends",@"user_about_me",@"user_relationships",@"user_birthday",@"user_location"];
        NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
        [self.fbPhoto setProfileID:@"user_id"];
        [self.fbPhoto setPictureMode:FBSDKProfilePictureModeSquare];
        [self.view addSubview:self.fbPhoto];
        
        
        
        
        
        
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture",@"fields",nil];
        FBSDKGraphRequest *request2 = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:params];
   
        [request2 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                // result is a dictionary with the user's Facebook data
                NSLog(@"result is %@",result);
                NSDictionary *userData = (NSDictionary *)result;
                NSDictionary * resultsDictionary = [result objectForKey:@"picture"];
                NSDictionary * dataDictionary = resultsDictionary[@"data"];
                NSString * pictureURL = dataDictionary[@"url"];
                NSString * email = result[@"email"];
                self.pictureUrl = pictureURL;
                NSLog(@"picture url is %@",self.pictureUrl);
                NSURL * url = [NSURL URLWithString:pictureURL];
                NSData * pictureData = [NSData dataWithContentsOfURL:url];
                UIImage * downloadedImage = [UIImage imageWithData:pictureData];
                    dispatch_async(dispatch_get_main_queue(), ^{
                    self.profilePictureImageView.image = downloadedImage;
                  self.dataForPicture = UIImagePNGRepresentation(downloadedImage);
                       
                        
                });
               
                
                
              
                
              
                
                
            }
            
        }];
        
        
    }
    
}
- (IBAction)login:(id)sender {
    PFUser * currentUser = [PFUser user];
   
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:self.dataForPicture];
    [currentUser setObject:imageFile forKey:@"profilePic"];
    currentUser.username = self.usernameTextField.text;
    currentUser.password = self.passwordTextField.text;
    currentUser.email = self.emailTextField.text;
   // [currentUser setObject:self.dataForPicture forKey:@"dataForPicture"];
     [currentUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
      {
          if(succeeded)
          {
              NSLog(@"saved");
          }
          else {
              NSLog(@"error");
          }
      }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    [self.tabBarController setSelectedIndex:1];
    [loginButton setHidden:YES];
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"USER Logged out");
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


@end
