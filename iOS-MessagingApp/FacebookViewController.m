//
//  FacebookViewController.m
//  iOS-MessagingApp
//
//  Created by Rich Blanchard on 7/28/15.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "FacebookViewController.h"
#import "ThreadCollectionView.h"

//WHEN FIRST LOGIN TO facebook
@interface FacebookViewController () <FBSDKLoginButtonDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSString * pictureUrl;

@property (nonatomic,strong) NSString * name;

@property (nonatomic,strong) NSString * email;

@property (nonatomic,strong) NSData * dataForPicture;

@property FBSDKLoginButton *loginButton;

@property FBSDKProfilePictureView *fbPhoto;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;


@property UIImageView *profilePictureImageView;
@property (nonatomic,strong) FBSDKProfile * profile;


@end

@implementation FacebookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self manageFacebookLogin];
    
    
    
    
}





- (void)manageFacebookLogin {
    // check to see if the user is already logged in
    if ([FBSDKAccessToken currentAccessToken] && [PFUser currentUser]) {
        NSLog(@"%@ is logged in",[PFUser currentUser]);
        [UIView setAnimationsEnabled:NO];
        self.view.hidden = YES;
        
        
        [self performSegueWithIdentifier:@"getOutOfLogin" sender:self];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:NO];
            self.view.hidden = NO;
        });
        
    } else if (![FBSDKAccessToken currentAccessToken] && ![PFUser currentUser]) {
        
        [self setUpFacebookLoginButton];
        [self setUpProfilePicture];
        [self getFacebookInformation];
        //put logic here to login
        
    } else if([FBSDKAccessToken currentAccessToken] && ![PFUser currentUser])
    {
        [UIView setAnimationsEnabled:NO];
        self.view.hidden = YES;
        
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:NO];
            self.view.hidden = NO;
        });
        
    }
    
}


- (IBAction)login:(id)sender {
    if([self checkTextField:self.usernameTextField] ==1 && [self checkTextField:self.passwordTextField] ==1 && [self checkTextField:self.emailTextField] ==1)
    {
        PFUser * newUser = [PFUser user];
        if (self.dataForPicture == nil) {
            NSData *dataForPicture = UIImagePNGRepresentation([UIImage imageNamed:@"profile-photo1"]);
            PFFile *imageFile = [PFFile fileWithName:@"image.png" data:dataForPicture];
            [newUser setObject:imageFile forKey:@"profilePic"];
        } else {
            PFFile *imageFile = [PFFile fileWithName:@"image.png" data:self.dataForPicture];
            [newUser setObject:imageFile forKey:@"profilePic"];
        }
        
        
        newUser.username = self.usernameTextField.text;
        newUser.password = self.passwordTextField.text;
        newUser.email = self.emailTextField.text;
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if(succeeded)
             {
                 NSLog(@"saved");
                 [self performSegueWithIdentifier:@"getOutOfLogin" sender:self];
             }
             else {
                 NSLog(@"error");
             }
         }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    [loginButton setHidden:YES];
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"You are logged in with facebook!" message:@"Now please fill out account details below" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"USER Logged out");
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
-(BOOL)checkTextField:(UITextField *)textField
{
    if([textField.text isEqualToString:@""] )
    {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"All three fields need text" message:@"Please make sure you fill out all of the fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}


#pragma mark - facebook layout Methods

- (void)setUpFacebookLoginButton {
    // set up the facebook login button
    self.loginButton = [[FBSDKLoginButton alloc] init];
    self.loginButton.delegate = self;
    self.loginButton.center = self.view.center;
    [self.view addSubview:self.loginButton];
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends",@"user_about_me",@"user_relationships",@"user_birthday",@"user_location"];
    
}



- (void)setUpProfilePicture {
    // set up the profile picture
    [self.fbPhoto setProfileID:@"user_id"];
    [self.fbPhoto setPictureMode:FBSDKProfilePictureModeSquare];
    [self.view addSubview:self.fbPhoto];
}

- (void)getFacebookInformation {
    // this is gettingninformation from facebook??
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture",@"fields",nil];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSLog(@"fetched user:%@", result);
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
-(void)getOutOfSignUpView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView setAnimationsEnabled:NO];
        self.view.hidden = NO;
    });
}



@end
