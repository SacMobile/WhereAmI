//
//  ViewController.m
//  WhereAmI
//
//  Created by Kevin Favro on 2/17/15.
//  Copyright (c) 2015 Kevin Favro. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *whereAmIButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)onButtonPress:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:true];

    self.nameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    NSString *greeting = [NSString stringWithFormat:@"Nice to meet you, %@", textField.text];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Well Hello There"
                                                                   message:greeting preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];

    [self presentViewController:alert animated:true completion:nil];

    return true;
}

- (IBAction)onButtonPress:(id)sender
{
    NSLog(@"the button was pressed");
}
@end
