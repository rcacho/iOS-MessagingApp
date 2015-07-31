//
//  ThreadCreationViewController.m
//  iOS-MessagingApp
//
//  Created by ricardo antonio cacho on 2015-07-29.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ThreadCreationViewController.h"
#import "LocationManagerHandler.h"

#define zoominMapArea 2100

@interface ThreadCreationViewController () <MKMapViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *topicTextField;

@property (weak, nonatomic) IBOutlet UITextField *postTextField;

@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;

@property (strong,nonatomic) UIImage * imageForGroup;

@property MKCircleView *areaOfMessage;

@end

@implementation ThreadCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.mapView.showsUserLocation = true;
    
}

#pragma mark - Map Methods


- (void) initiateMap {
    LocationManagerHandler *theLocationManagerHandler = [LocationManagerHandler defaultLocationManagerHandler];

    _currentLocation = [[CLLocation alloc] initWithLatitude:theLocationManagerHandler.currentLocation.coordinate.latitude longitude:theLocationManagerHandler.currentLocation.coordinate.longitude];

    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude - 0.0075, _currentLocation.coordinate.longitude - 0.0008);
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];

}


-(void)mapViewDidFinishLoadingMap:(nonnull MKMapView *)mapView{
        [self initiateMap];
}

#pragma mark - Circular Overlay

- (void)addCircle:(NSInteger)radius {
    CLLocationCoordinate2D center = {_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude};
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:radius];
    [self.mapView addOverlay:circle];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    self.areaOfMessage = [[MKCircleView alloc] initWithOverlay:overlay];
    [self.areaOfMessage setFillColor:[UIColor redColor]];
    [self.areaOfMessage setAlpha:0.5f];
    return self.areaOfMessage;
}


#pragma mark - IBActions

- (IBAction)submitNewGroup:(UIButton *)sender {
    
    [self.collection addNewThread:self.topicTextField.text withLat:[NSNumber numberWithFloat:self.currentLocation.coordinate.latitude] andLong:[NSNumber numberWithFloat:self.currentLocation.coordinate.longitude] andRadius:[NSNumber numberWithFloat:self.areaOfMessage.circle.radius]andImage:self.imageForGroup andPost:self.postTextField.text];
}

- (IBAction)expandArea:(UISlider *)sender {
    [self.mapView removeOverlay:self.areaOfMessage.circle];
    [self addCircle:sender.value * 100];
}

#pragma mark - TextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.topicTextField]) {
        // check?
    } else if ([textField isEqual:self.postTextField]) {
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark - PickerView delegate methods
- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
  //  self.imageView.image = chosenImage;
    self.imageForGroup = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
