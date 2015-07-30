//
//  ThreadCreationViewController.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-29.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ThreadCreationViewController.h"

@interface ThreadCreationViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *topicTextField;

@property (weak, nonatomic) IBOutlet UITextField *postTextField;

@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;

@end

@implementation ThreadCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (IBAction)submitNewGroup:(UIButton *)sender {
}

@end
