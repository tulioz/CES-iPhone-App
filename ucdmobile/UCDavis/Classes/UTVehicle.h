//
//  Vehicle.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTVehicle : NSObject {
	NSInteger vehicleId;
	NSString *routeTag;
	NSString *dirTag;
	NSNumber *latitude;
	NSNumber *longitude;
	NSInteger secondsSinceReport;
	Boolean predictable; // can we make predictions on this bus
	NSInteger heading; // orientation by degrees from north
}

@property(nonatomic) NSInteger vehicleId;
@property(nonatomic, retain) NSString *routeTag;
@property(nonatomic, retain) NSString *dirTag;
@property(nonatomic, retain) NSNumber *latitude;
@property(nonatomic, retain) NSNumber *longitude;
@property(nonatomic) NSInteger secondsSinceReport;
@property(nonatomic) Boolean predictable;
@property(nonatomic) NSInteger heading;

@end
