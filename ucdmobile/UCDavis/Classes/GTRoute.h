//
//  GTRoute.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/14/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GTRoute : NSObject {
	NSString *longName;
	NSString *routeId;
}

@property (nonatomic, retain) NSString *longName;
@property (nonatomic, retain) NSString *routeId;

- (id)initWithRouteId:(NSString *)aId longName:(NSString *)ln;

@end