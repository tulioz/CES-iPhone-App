//
//  TransitHelper.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/12/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "TransitHelper.h"
#import "FMDatabase.h"
#import "GTRoute.h"
#import "GTCalendar.h"
#import "GTStop.h"

#import "CMBuilding.h"
#import "CMCollege.h"
#import "CMDepartment.h"
#import "Course.h"
#import "CourseTime.h"
#import "CMPerson.h"
#import "CMStaff.h"
#import "CMStudent.h"

static TransitHelper *sharedInstance = nil;

@interface TransitHelper (Private)

- (NSString *)likeStringWithString:(NSString *)nonLikeString;

@end

@implementation TransitHelper

#pragma mark -
#pragma mark class instance methods

@synthesize db;

- (id)init {
	if(self = [super init]) {
		self.db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"transit" ofType:@"db"]];
		// open the database
		[self.db open];
	}
	return self;	
}

#pragma mark Calendar

- (NSString *)calendarWithDate:(NSDate *)date {
	// find the calendar for today
	NSArray *weekdayArray = [NSArray arrayWithObjects:@"sunday", @"monday", @"tuesday", @"wednesday", @"thursday", @"friday", @"saturday", nil];
	NSInteger weekdayIndex = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday] - 1; // Sunday = 1-1 = 0, Saturday = 7-1 = 6
	NSString *weekday = [weekdayArray objectAtIndex:weekdayIndex];
	
	NSString *query = [NSString stringWithFormat:@"select service_id, start_date, end_date from calendar where start_date <= ? and end_date >= ? and %@ = 1", weekday];
	
	FMResultSet *rs = [self.db executeQuery:query, [date description], [date description]];
	
	NSString *serviceId = nil;
	
	while([rs next]) {
		serviceId = [rs stringForColumn:@"service_id"];
		break; // exit after first one
	}
	
	return serviceId;
}

#pragma mark Route

- (NSArray *)routesByCalendar:(NSString *)serviceId {
	FMResultSet *rs = [self.db executeQuery:@"select route_id, route_long_name from opt_routes where opt_routes.service_id = ? order by route_id", serviceId];
	
	NSMutableArray *routes = [NSMutableArray array];
	
	while([rs next]) {
		GTRoute *route = [[GTRoute alloc] initWithRouteId:[rs stringForColumn:@"route_id"] longName:[rs stringForColumn:@"route_long_name"]];
		[routes addObject:route];
		[route release];
	}
	
	return routes;
}

- (NSArray *)routesByDate:(NSDate *)date {
	// find the calendar for date
	NSArray *weekdayArray = [NSArray arrayWithObjects:@"sunday", @"monday", @"tuesday", @"wednesday", @"thursday", @"friday", @"saturday", nil];
	NSInteger weekdayIndex = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday] - 1; // Sunday = 1-1 = 0, Saturday = 7-1 = 6
	NSString *weekday = [weekdayArray objectAtIndex:weekdayIndex];
	
	NSString *query = [NSString stringWithFormat:@"select route_id, route_long_name from opt_routes, calendar where opt_routes.service_id = calendar.service_id and calendar.start_date <= ? and calendar.end_date >= ? and %@ = 1 order by route_id", weekday];
	FMResultSet *rs = [self.db executeQuery:query, [date description], [date description]];
	
	NSMutableArray *routes = [NSMutableArray array];
	
	while([rs next]) {
		GTRoute *route = [[GTRoute alloc] initWithRouteId:[rs stringForColumn:@"route_id"] longName:[rs stringForColumn:@"route_long_name"]];
		[routes addObject:route];
		[route release];
	}
	
	return routes;
}

- (GTRoute *)routeById:(NSString *)routeId {	
	FMResultSet *rs = [self.db executeQuery:@"select route_id, route_long_name from routes where route_id = ?", routeId];
	
	GTRoute *route = nil;
	
	while([rs next]) {
		route = [[GTRoute alloc] initWithRouteId:[rs stringForColumn:@"route_id"] longName:[rs stringForColumn:@"route_long_name"]];
		break; // exit after first one
	}
	
	return [route autorelease];
}

#pragma mark Stop

- (NSArray *)stopsByRoute:(GTRoute *)route calendar:(NSString *)serviceId {
	FMResultSet *rs = [self.db executeQuery:@"select stops.stop_id as stop_id, stop_lat, stop_lon, stop_name, stop_desc from stops, opt_stops_routes where stops.stop_id = opt_stops_routes.stop_id and route_id = ? and service_id = ? order by stop_name", route.routeId, serviceId];
	
	NSMutableArray *stops = [NSMutableArray array];
	
	while([rs next]) {
		GTStop *stop = [[GTStop alloc] initWithStopId:[rs intForColumn:@"stop_id"] latitude:[NSNumber numberWithDouble:[rs doubleForColumn:@"stop_lat"]] longitude:[NSNumber numberWithDouble:[rs doubleForColumn:@"stop_lon"]] name:[rs stringForColumn:@"stop_name"] description:[rs stringForColumn:@"stop_desc"]];
		[stops addObject:stop];
		[stop release];
	}
	
	return stops;
}

- (NSArray *)stopsLikeName:(NSString *)name calendar:(NSString *)calendar {
	NSString *containsName = [NSString stringWithFormat:@"%%%@%%", name]; // '%%' escapes a percent
	FMResultSet *rs = [self.db executeQuery:@"select s.stop_id as stop_id, s.stop_lat as stop_lat, s.stop_lon as stop_lon, s.stop_name as stop_name, s.stop_desc as stop_desc, r.route_id as route_id, r.route_long_name as route_long_name from opt_routes r, opt_stops_routes sr, stops s where s.stop_id=sr.stop_id and r.service_id=sr.service_id and r.route_id=sr.route_id and r.service_id = ? and s.stop_name like ? order by s.stop_name, r.route_id", calendar, containsName];
	
	NSMutableArray *stops = [NSMutableArray array];
	
	while([rs next]) {
		GTStop *stop = [[GTStop alloc] initWithStopId:[rs intForColumn:@"stop_id"] latitude:[NSNumber numberWithDouble:[rs doubleForColumn:@"stop_lat"]] longitude:[NSNumber numberWithDouble:[rs doubleForColumn:@"stop_lon"]] name:[rs stringForColumn:@"stop_name"] description:[rs stringForColumn:@"stop_desc"]];
		GTRoute *route = [[GTRoute alloc] initWithRouteId:[rs stringForColumn:@"route_id"] longName:[rs stringForColumn:@"route_long_name"]];
		[stops addObject:[NSDictionary dictionaryWithObjectsAndKeys:stop, @"stop", route, @"route", nil]];
	}
	
	return stops;
}

#pragma mark Stop Times

- (NSArray *)stopTimesByStop:(GTStop *)stop route:(GTRoute *)route calendar:(NSString *)serviceId {
	NSString *query = [NSString stringWithFormat:@"select arrival_time from opt_stop_times where stop_id = %d and route_id = '%@' and service_id = '%@' order by arrival_time", stop.stopId, route.routeId, serviceId];
	FMResultSet *rs = [self.db executeQuery:query];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	
	NSMutableArray *times = [NSMutableArray array];
	
	while([rs next]) {
		NSDate *d = [rs dateForColumn:@"arrival_time"];
		[times addObject:[dateFormatter stringFromDate:d]];
	}
	[dateFormatter release];
	
	return times;
}

#pragma mark -
#pragma mark Singleton methods

+ (TransitHelper *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil)
			sharedInstance = [[TransitHelper alloc] init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

@end

