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
@interface FacebookViewController () <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NSString * pictureUrl;

@property (nonatomic,strong) NSString * name;

@property (nonatomic,strong) NSString * email;

@property (nonatomic,strong) NSData * dataForPicture;


@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end

@implementation FacebookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self manageFacebookLogin];
}





- (void)manageFacebookLogin {
    

        
     if ([PFUser currentUser])
     {
        [UIView setAnimationsEnabled:NO];
        self.view.hidden = YES;
         [PFUser logOut];
        
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
    [alertView show];
    
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


-(void)getOutOfSignUpView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView setAnimationsEnabled:NO];
        self.view.hidden = NO;
    });
}
- (IBAction)addImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //  self.imageView.image = chosenImage;
    self.dataForPicture = UIImagePNGRepresentation(chosenImage);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



@end
