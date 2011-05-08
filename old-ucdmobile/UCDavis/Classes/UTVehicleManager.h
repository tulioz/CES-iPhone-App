//
//  Unitrans.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTVehicleManager : NSObject {
	NSInteger lastUpdateTime; // in secs from epoch
	NSString *routeTag;
	NSMutableDictionary *vehicleDictionary;
}

@property(nonatomic) NSInteger lastUpdateTime;
@property(nonatomic, retain) NSString *routeTag;

- (id)init;
- (id)initWithRouteTag:(NSString *)route;
-(NSArray *)vehicles;
-(void)updatePositions;

@end
