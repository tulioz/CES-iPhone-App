//
//  UTPredictionManager.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTPredictions : NSObject {
	NSMutableDictionary *predictionDictionary;
	NSString *routeTag;
	NSInteger stopId;
}

@property(nonatomic, retain) NSMutableDictionary *predictionDictionary;
@property(nonatomic, retain) NSString *routeTag;
@property(nonatomic) NSInteger stopId;

- (id)initWithRouteTag:(NSString *)aRouteTag stopId:(NSInteger)aStopId;

@end
