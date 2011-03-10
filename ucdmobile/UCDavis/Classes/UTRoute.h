//
//  UTStopManager.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTRoute : NSObject {
	NSString *tag;
	NSString *title;
	NSString *color;
	
	NSArray *stops;

	NSString *directionTitle;
}

@property(nonatomic, retain) NSString *tag;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *color;

@property(nonatomic, retain) NSArray *stops;

@property(nonatomic, retain) NSString *directionTitle;

- (id)initWithRouteTag:(NSString *)routeTag;

@end
