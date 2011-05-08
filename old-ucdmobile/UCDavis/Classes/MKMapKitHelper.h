//
//  MKMapKitHelper.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapKitHelper : NSObject {

}

//static inline CLLocationCoordinate2D CLLocationCoordinate2DMake(CLLocationDegrees latitude, CLLocationDegrees longitude);
+ (MKCoordinateRegion)regionToFitAnnotations:(NSArray *)annotations;

@end
