//
//  GTStop.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/14/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTStop : NSObject {
	NSInteger stopId;
	NSString *description;
	NSString *name;
	NSNumber *latitude;
	NSNumber *longitude;
}

@property(nonatomic) NSInteger stopId;
@property(nonatomic, retain) NSString *description;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSNumber *latitude;
@property(nonatomic, retain) NSNumber *longitude;

- (id)initWithStopId:(NSInteger)aId latitude:(NSNumber *)lat longitude:(NSNumber *)lng name:(NSString *)aName description:(NSString *)desc;

@end
