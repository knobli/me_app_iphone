//
//  RTGVMapViewController.m
//  Me App
//
//  Created by XCode Developer on 7/25/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "RTGVMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AddressAnnotation.h"

@interface RTGVMapViewController ()

@end

@implementation RTGVMapViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.myData = [[RTGVMyData alloc] init];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //[geocoder geocodeAddressString:@"350 5th Avenue New York, NY"
    
    NSString *locationString = [NSString stringWithFormat:@"%@, %@, %@",
                                [self.myData getField:Address],
                                [self.myData getField:City],
                                [self.myData getField:State]];
    [geocoder geocodeAddressString:locationString
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (error) {
                         NSLog(@"Geocode failed with error: %@", error);
                         return;
                     }
                     
                     if(placemarks && placemarks.count > 0)
                     {
                         CLPlacemark *placemark = placemarks[0];
                         CLLocation *location = placemark.location;
                         CLLocationCoordinate2D coords = location.coordinate;
                         
                         NSLog(@"Latitude = %f, Longitude = %f",
                               coords.latitude, coords.longitude);
                         MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coords, 800, 800);
                         [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
                         AddressAnnotation *addressAnnot = [[AddressAnnotation alloc] initWithCoordinate:coords];
                         [addressAnnot setTitle:locationString];
                         [self.mapView addAnnotation:addressAnnot];
                     }
                 }
     ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
