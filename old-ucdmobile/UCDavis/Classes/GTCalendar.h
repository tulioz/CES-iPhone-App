//
//  GTCalendar.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/12/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GTCalendar : NSObject {
	NSString * serviceId;
	NSDate * startDate;
	NSDate * endDate;
	/*
	Boolean monday;
	Boolean tuesday;
	Boolean wednesday;
	Boolean thursday;
	Boolean friday;
	Boolean saturday;
	Boolean sunday;*/
}

@property (nonatomic, retain) NSString * serviceId;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;

- (id)initWithServiceId:(NSString *)aServiceId startDate:(NSDate *)aStartDate endDate:(NSDate *)aEndDate;

@end
