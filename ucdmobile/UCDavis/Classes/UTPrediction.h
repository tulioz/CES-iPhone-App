//
//  UTPrediction.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTPrediction : NSObject {
	NSInteger seconds;
	NSInteger minutes;
	NSInteger epochTime;
	NSInteger vehicleId;
}

@property(nonatomic) NSInteger seconds;
@property(nonatomic) NSInteger minutes;
@property(nonatomic) NSInteger epochTime;
@property(nonatomic) NSInteger vehicleId;


@end
