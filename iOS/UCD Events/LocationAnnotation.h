//
//  LocationAnnotation.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationItem.h"

@interface LocationAnnotation : NSObject<MKAnnotation> {
    LocationItem *_location;
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, retain) LocationItem *location;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
