//
//  UTStop.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTStop : NSObject {
	NSInteger stopId;
	NSString *title;
	NSString *dirTag;
	NSNumber *latitude;
	NSNumber *longitude;
}

@property(nonatomic) NSInteger stopId;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *dirTag;
@property(nonatomic, retain) NSNumber *latitude;
@property(nonatomic, retain) NSNumber *longitude;

@end
