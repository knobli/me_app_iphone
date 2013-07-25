//
//  RTGVMapViewController.h
//  Me App
//
//  Created by XCode Developer on 7/25/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTGVMyData.h"
#import <MapKit/MapKit.h>

@interface RTGVMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic,strong) RTGVMyData* myData;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end
