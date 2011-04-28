//
//  MapViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : TTModelViewController <MKMapViewDelegate> {
    MKMapView *mapView;
}

@property (nonatomic, retain) MKMapView *mapView;

-(void)setCurrentLocation:(CLLocation *)location;

@end
