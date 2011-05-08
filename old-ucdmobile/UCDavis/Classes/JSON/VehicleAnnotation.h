//
//  VehicleAnnotation.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMAnnotation.h"

@class UTVehicle;

@interface VehicleAnnotation : CMAnnotation {
	UTVehicle *vehicle;
}

@property (nonatomic, retain) UTVehicle *vehicle;

- (id)initWithVehicle:(UTVehicle *)aVehicle;


@end
