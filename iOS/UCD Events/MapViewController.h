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
#import "Three20/Three20.h"
//#import "LocationItem.h"

@interface MapViewController : TTModelViewController <MKMapViewDelegate> {
    MKMapView *mapView;
}


@property (nonatomic, retain) MKMapView *mapView;

-(void)setCurrentLocation:(CLLocation *)location;

@end


@interface AnnotationDelegate : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
}

@end