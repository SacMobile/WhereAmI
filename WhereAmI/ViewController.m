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

@interface ViewController ()
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *whereAmIButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
