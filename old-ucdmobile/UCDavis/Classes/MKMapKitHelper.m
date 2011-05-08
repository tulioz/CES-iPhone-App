//
//  MKMapKitHelper.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "MKMapKitHelper.h"

@implementation MKMapKitHelper

// Convenience Method for creating a CLLocationCoordinate2D
//static inline CLLocationCoordinate2D CLLocationCoordinate2DMake(CLLocationDegrees latitude, CLLocationDegrees longitude) {
//	CLLocationCoordinate2D coordinate;
//	coordinate.latitude = latitude;
//	coordinate.longitude = longitude;
//	return coordinate;
//}

// returns a region that fits the passed in annotations
+ (MKCoordinateRegion)regionToFitAnnotations:(NSArray *)annotations {
	if([annotations count] == 0) {
		// they passed in an empty array pass back kemper hall
		return MKCoordinateRegionMake(CLLocationCoordinate2DMake(38.537051, -121.754909), MKCoordinateSpanMake(.005, .005));
	}
	// set min and max for two points
    CLLocationCoordinate2D northWest = CLLocationCoordinate2DMake(-90, 180);	
    CLLocationCoordinate2D southEast = CLLocationCoordinate2DMake(90, -180);
	
    for(id<MKAnnotation> annotation in annotations) {
        northWest.longitude = fmin(northWest.longitude, annotation.coordinate.longitude);
        northWest.latitude = fmax(northWest.latitude, annotation.coordinate.latitude);
		
        southEast.longitude = fmax(southEast.longitude, annotation.coordinate.longitude);
        southEast.latitude = fmin(southEast.latitude, annotation.coordinate.latitude);
    }
	
    MKCoordinateRegion region;
    region.center.latitude = (northWest.latitude + southEast.latitude) / 2.0;
    region.center.longitude = (southEast.longitude + northWest.longitude) / 2.0;
	// add padding in each direction
    region.span.latitudeDelta = fabs(northWest.latitude - southEast.latitude) * 1.1;
    region.span.longitudeDelta = fabs(southEast.longitude - northWest.longitude) * 1.1;
	return region;
}

@end
