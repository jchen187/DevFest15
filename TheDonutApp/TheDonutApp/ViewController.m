//
//  ViewController.m
//  TheDonutApp
//
//  Created by Johnny Chen on 2/6/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    GMSMapView *mapView_;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    //[super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Create a GMSCameraPosition that tells the map to display the coordinate -33.86,151.20 at zoom level 6
    GMSCameraPosition *camera = [GMSCameraPosition
                                 cameraWithLatitude:mapView_.myLocation.coordinate.latitude
                                 longitude:mapView_.myLocation.coordinate.longitude
                                 zoom:16];
    
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    NSLog(@"User's location: %@", mapView_.myLocation);

    //mapView_.mapType = kGMSTypeSatellite;
    self.view = mapView_;
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES; //if know your location and you press it shows your location
    
    
    
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
