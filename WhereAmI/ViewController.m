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

@interface ViewController () <UITextFieldDelegate, MKMapViewDelegate>
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
    self.mapView.delegate = self;

    self.whereAmIButton.enabled = false;
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

#pragma MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.whereAmIButton.enabled = true;
}

#pragma mark - Target / Action

- (IBAction)onButtonPress:(id)sender
{
    CLLocation *currentLocation = self.mapView.userLocation.location;
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {

        if (!error && placemarks.count) {
            CLPlacemark *placemark = [placemarks firstObject];
            NSString *city = placemark.addressDictionary[@"City"];
            NSString *message = [NSString stringWithFormat:@"Hello %@, it looks like you're in %@! Hope you're having a great time!", self.nameTextField.text, city];

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"There You Are!" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"You Found Me!" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:true completion:nil];
        }
    }];

}
@end
