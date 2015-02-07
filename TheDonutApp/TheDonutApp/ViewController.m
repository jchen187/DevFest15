//
//  ViewController.m
//  TheDonutApp
//
//  Created by Johnny Chen on 2/6/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    GMSMapView *mapView_;
    CLLocationManager *locationManager_;
    GMSCameraPosition *camera;
}

@end

/*
 Consumer Key       n70vACBi5J3IYJKNLnYskQ
 Consumer Secret	H8VDPMZXXt_ek9mhmcRVTEsS-fI
 Token              3zhbwtmitKazrYPq6g_l-brkNz8xnUvE
 Token Secret       ycCvibom2QcNoaZa6AZY3M2aYkU
 
 */


@implementation ViewController

- (void)viewDidLoad {
    //[super viewDidLoad];
    
    /* Matt helped me but it didnt work
     locationManager_ = [[CLLocationManager alloc] init];
     [locationManager_ requestWhenInUseAuthorization];
     locationManager_.delegate = self;
     [locationManager_ startUpdatingLocation];
     
     [mapView_ addObserver:@"self" forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
     */
    
    if ([CLLocationManager locationServicesEnabled]) {
        if (locationManager_ == nil) {
            locationManager_ = [[CLLocationManager alloc] init];
            locationManager_.delegate = self;
            if ([locationManager_ respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                [locationManager_ requestWhenInUseAuthorization];
            }
        }
    }
    [locationManager_ startUpdatingLocation];
    
    camera = [GMSCameraPosition cameraWithLatitude: locationManager_.location.coordinate.latitude
                                         longitude: locationManager_.location.coordinate.longitude
                                              zoom:14];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    
    //mapView_.mapType = kGMSTypeSatellite;
    self.view = mapView_;
    mapView_.settings.compassButton = YES;
    
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES; //if know your location and you press it shows your location
    
    [self createMarkerToMarkYourPosition];
    
    NSLog(@"%d",[self isYelpInstalled]);
    
}

-(BOOL)isYelpInstalled { return [[UIApplication sharedApplication]
                                 canOpenURL:[NSURL URLWithString:@"yelp:"]]; }

- (void) createMarkerToMarkYourPosition{
    //Create a marker in the center of the map
    GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];
    //marker.icon = [UIImage imageNamed:@"house"];
    marker.opacity = 0.6;
    marker.position = camera.target;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.title = @"Your position";
    //marker.snippet = @"Australia";
    marker.map = mapView_;
}

#pragma mark - GMSMapViewDelegate
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    NSLog(@"You tapped at %f,%f",coordinate.latitude,coordinate.longitude);
}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
    //gesture = TRUE;
    //removes all markers
    //[mapView_ clear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
