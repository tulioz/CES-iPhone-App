//
//  CMBuildingAnnotation.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CMAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString *)aTitle subtitle:(NSString *)aSubtitle;

@end
