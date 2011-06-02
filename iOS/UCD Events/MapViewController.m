//
//  MapViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

@synthesize mapView;

-(void)viewDidLoad {
    self.title = @"Map";
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    [self.mapView setDelegate:self];
    NSLog(@"type of mapview is %@", [self.mapView class]);
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:38.537051 longitude:-121.754909];
    
    [self setCurrentLocation:myLocation];
    
//    from http://stackoverflow.com/questions/2473706/how-do-i-zoom-an-mkmapview-to-the-users-current-location-without-cllocationmanage
    
    self.mapView.showsUserLocation = TRUE;
    
}

//from iphone-sdk-development book
-(void)setCurrentLocation:(CLLocation *)location {
    MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
    region.center = location.coordinate;
    region.span.longitudeDelta = 0.035f;
    region.span.longitudeDelta = 0.035f;
    [self.mapView setRegion:region animated:YES];
}

// add a dealloc
- (void) dealloc
{
    TT_RELEASE_SAFELY(mapView);
}


@end
