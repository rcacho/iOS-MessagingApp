//
//  CreateNewGroupViewController.m
//  iOS Messaging App
//
//  Created by Rich Blanchard on 7/27/15.
//  Copyright (c) 2015 Rich. All rights reserved.
//

#import "CreateNewGroupViewController.h"

@interface CreateNewGroupViewController () <UITextFieldDelegate>

@end

@implementation CreateNewGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"locationCoordinate is %f",self.locationCoordinate.latitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(bool)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (IBAction)createGroup:(id)sender {
    Group * newGroup = [[Group alloc]initWithGroupName:self.groupNameTextField.text andTopic:self.groupTopicTextField.text andLocation:self.locationCoordinate];
    [self.delegate passBackGroup:newGroup];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
