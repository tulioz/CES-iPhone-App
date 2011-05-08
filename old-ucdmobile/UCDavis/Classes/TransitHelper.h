//
//  TransitHelper.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/12/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class GTRoute;
@class GTStop;

@interface TransitHelper : NSObject {
	FMDatabase *db;
}

@property (nonatomic, retain) FMDatabase *db;

+ (TransitHelper *)sharedInstance;

- (NSString *)calendarWithDate:(NSDate *)date;
- (NSArray *)routesByCalendar:(NSString *)serviceId;
- (GTRoute *)routeById:(NSString *)routeId;
- (NSArray *)stopsByRoute:(GTRoute *)route calendar:(NSString *)serviceId;
- (NSArray *)stopTimesByStop:(GTStop *)stop route:(GTRoute *)route calendar:(NSString *)serviceId;
- (NSArray *)stopsLikeName:(NSString *)name calendar:(NSString *)calendar;

@end
