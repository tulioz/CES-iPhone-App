//
//  DatabaseHelper.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/1/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "DatabaseHelper.h"
#import "FMDatabase.h"
#import "CMBuilding.h"
#import "CMCollege.h"
#import "CMDepartment.h"
#import "Course.h"
#import "CourseTime.h"
#import "CMPerson.h"
#import "CMStaff.h"
#import "CMStudent.h"

static DatabaseHelper *sharedInstance = nil;

@interface DatabaseHelper (Private)

- (NSString *)likeStringWithString:(NSString *)nonLikeString;

@end

@implementation DatabaseHelper

#pragma mark -
#pragma mark class instance methods

@synthesize db;

- (id)init {
	if(self = [super init]) {
		self.db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"webservice" ofType:@"db"]];
		// open the database
		[self.db open];
	}
	return self;	
}

#pragma mark Departments

- (NSArray *)buildings {
	FMResultSet *rs = [self.db executeQuery:@"select id, name, latitude, longitude from building"];
	
	NSMutableArray *buildings = [NSMutableArray array];
	
	while([rs next]) {
		CMBuilding *building = [[CMBuilding alloc] initWithName:[rs stringForColumn:@"name"] latitude:[NSNumber numberWithDouble:[rs doubleForColumn:@"latitude"]] longitude:[NSNumber numberWithDouble:[rs doubleForColumn:@"longitude"]] primaryKey:[rs intForColumn:@"id"]];
		[buildings addObject:building];
		[building release];
	}
	
	return buildings;
}

- (CMBuilding *)buildingById:(NSInteger)pk {
	FMResultSet *rs = [self.db executeQuery:@"select id, name, latitude, longitude from building where id = ?", [NSString stringWithFormat:@"%d", pk]];
	
	CMBuilding *building = nil;
	
	while([rs next]) {
		building = [[CMBuilding alloc] initWithName:[rs stringForColumn:@"name"] latitude:[NSNumber numberWithDouble:[rs doubleForColumn:@"latitude"]] longitude:[NSNumber numberWithDouble:[rs doubleForColumn:@"longitude"]] primaryKey:[rs intForColumn:@"id"]];
		break; // exit after first one
	}
	
	return [building autorelease];
}

#pragma mark Colleges

- (NSArray *)colleges {
	FMResultSet *rs = [self.db executeQuery:@"select id, name from college"];
	
	NSMutableArray *colleges = [NSMutableArray array];
	
	while([rs next]) {
		CMCollege *college = [[CMCollege alloc] initWithName:[rs stringForColumn:@"name"] primaryKey:[rs intForColumn:@"id"]];
		[colleges addObject:college];
		[college release];
	}
	
	return colleges;
}

#pragma mark Departments

- (NSArray *)departmentsByCollege:(CMCollege *)college {
	FMResultSet *rs = [self.db executeQuery:@"select id, name, abbr, url, building_id from department where college_id = ? order by abbr", [NSString stringWithFormat:@"%d", college.pk]];
	
	NSMutableArray *departments = [NSMutableArray array];
	
	while([rs next]) {
		CMDepartment *department = [[CMDepartment alloc] initWithName:[rs stringForColumn:@"name"] abbreviation:[rs stringForColumn:@"abbr"] departmentURL:[rs stringForColumn:@"url"] building:[self buildingById:[rs intForColumn:@"building_id"]] primaryKey:[rs intForColumn:@"id"]];
		[departments addObject:department];
		[department release];
	}
	
	return departments;
}

- (CMDepartment *)departmentById:(NSInteger)pk {
	FMResultSet *rs = [self.db executeQuery:@"select id, name, abbr, url, building_id from department where id = ?", [NSString stringWithFormat:@"%d", pk]];
	
	CMDepartment *department = nil;
	
	while([rs next]) {
		department = [[CMDepartment alloc] initWithName:[rs stringForColumn:@"name"] abbreviation:[rs stringForColumn:@"abbr"] departmentURL:[rs stringForColumn:@"url"] building:[self buildingById:[rs intForColumn:@"building_id"]] primaryKey:[rs intForColumn:@"id"]];
		break; // exit after first one
	}
	
	return [department autorelease];
}

#pragma mark Courses

- (NSArray *)courseDictionariesByDepartment:(CMDepartment *)department {
	FMResultSet *rs = [self.db executeQuery:@"select title, number, count(*) as count from course where department_id = ? group by number", [NSString stringWithFormat:@"%d", department.pk]];
	
	NSMutableArray *courses = [NSMutableArray array];
	
	while([rs next]) {
		NSDictionary *courseDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"title"], @"title", [rs stringForColumn:@"number"], @"number", [rs stringForColumn:@"count"], @"count", nil];
		[courses addObject:courseDictionary];
	}
	
	return courses;
}

- (NSArray *)courseDictionariesLikeName:(NSString *)name {
	NSString *containsName = [NSString stringWithFormat:@"%%%@%%", name]; // '%%' escapes a percent
	FMResultSet *rs = [self.db executeQuery:@"select department_id, title, number, count(*) as count from course, department where course.department_id = department.id and (title like ? or abbr||number like ? or abbr||' '||number like ?) group by department_id, number", containsName, containsName, containsName];
	
	NSMutableArray *courses = [NSMutableArray array];
	
	while([rs next]) {
		NSDictionary *courseDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"title"], @"title", [rs stringForColumn:@"number"], @"number", [rs stringForColumn:@"count"], @"count", [self departmentById:[rs intForColumn:@"department_id"]], @"department", nil];
		[courses addObject:courseDictionary];
	}
	
	return courses;
}

- (NSArray *)coursesByNumber:(NSString *)number department:(CMDepartment *)department {
	FMResultSet *rs = [self.db executeQuery:@"select id, crn, type, section, instructor, seats, title, units, number from course where department_id = ? and number = ? order by section", [NSString stringWithFormat:@"%d", department.pk], number];
	
	NSMutableArray *courses = [NSMutableArray array];
	
	while([rs next]) {
		Course *course = [[Course alloc] initWithTitle:[rs stringForColumn:@"title"] number:[rs stringForColumn:@"number"] crn:[rs stringForColumn:@"crn"] type:[rs stringForColumn:@"type"] section:[rs stringForColumn:@"section"] units:[rs stringForColumn:@"units"] instructor:[rs stringForColumn:@"instructor"] seats:[rs stringForColumn:@"seats"] primaryKey:[rs intForColumn:@"id"]];
		course.courseTimes = [self courseTimesByCourse:course];
		[courses addObject:course];
		[course release];
	}
	
	return courses;
}

- (NSDictionary *)courseMetadataDictionaryByDepartment:(CMDepartment *)dept course:(Course *)course {
	FMResultSet *rs = [self.db executeQuery:@"select title, description from course_metadata where department_id = ? and number = ?", [NSString stringWithFormat:@"%d", dept.pk], course.number];
	
	NSDictionary *courseMetadataDictionary = nil;
	while([rs next]) {
		courseMetadataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"title"], @"title", [rs stringForColumn:@"description"], @"description", nil];
		break; // stop after first one
	}
	
	return courseMetadataDictionary;
}


- (NSArray *)courseTextbookDictionariesByDepartment:(CMDepartment *)dept course:(Course *)course {
	FMResultSet *rs = [self.db executeQuery:@"select isbn, title from coursetextbook where department_id = ? and number = ?", [NSString stringWithFormat:@"%d", dept.pk], course.number];
	
	NSMutableArray *textbooks = [NSMutableArray array];
	
	while([rs next]) {
		[textbooks addObject:[NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"isbn"], @"isbn", [rs stringForColumn:@"title"], @"title", nil]];
	}
	
	return textbooks;
}

#pragma mark Course Times

- (NSArray *)courseTimesByCourse:(Course *)course {
	FMResultSet *rs = [self.db executeQuery:@"select id, days, time, building_id, building_name, room from coursetime where course_id = ?", [NSString stringWithFormat:@"%d", course.pk]];
	
	NSMutableArray *courseTimes = [NSMutableArray array];
	
	while([rs next]) {
		CourseTime *courseTime = [[CourseTime alloc] initWithDays:[rs stringForColumn:@"days"] time:[rs stringForColumn:@"time"] buildingName:[rs stringForColumn:@"building_name"] room:[rs stringForColumn:@"room"] primaryKey:[rs intForColumn:@"id"]];
		courseTime.building = [self buildingById:[rs intForColumn:@"building_id"]];
		[courseTimes addObject:courseTime];
		[courseTime release];
	}
	
	return courseTimes;
}

#pragma mark People

- (CMPerson *)personWithResultSet:(FMResultSet *)rs {
	CMPerson *person = nil;
	if(![[rs stringForColumn:@"department"] isEqualToString:@""]) {
		// staff do not have a student level
		person = [[CMStaff alloc] initWithName:[rs stringForColumn:@"name"] email:[rs stringForColumn:@"email"] address:[rs stringForColumn:@"address"] title:[rs stringForColumn:@"title"] phone:[rs stringForColumn:@"phone"] department:[rs stringForColumn:@"department"] website:[rs stringForColumn:@"website"] primaryKey:[rs intForColumn:@"id"]];
	} else if(![[rs stringForColumn:@"student_level"] isEqualToString:@""]){
		// student
		person = [[CMStudent alloc] initWithName:[rs stringForColumn:@"name"] email:[rs stringForColumn:@"email"] studentLevel:[rs stringForColumn:@"student_level"] major:[rs stringForColumn:@"major"] primaryKey:[rs intForColumn:@"id"]];
	} else {
		person = [[CMPerson alloc] initWithName:[rs stringForColumn:@"name"] email:[rs stringForColumn:@"email"] primaryKey:[rs intForColumn:@"id"]];
	}
	return [person autorelease];
}

- (NSArray *)peopleWithNameLike:(NSString *)name {
	FMResultSet *rs = [self.db executeQuery:@"select id, name, email, title, department, student_level, major, address, phone, website from person where name like ? order by name", [self likeStringWithString:name]];
	
	NSMutableArray *people = [NSMutableArray array];
	
	while([rs next]) {
		[people addObject:[self personWithResultSet:rs]];
	}
	
	return people;
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)likeStringWithString:(NSString *)nonLikeString {
	NSArray *nameComponents = [nonLikeString componentsSeparatedByString:@" "];
	NSString *likeString = nil;	
	if([nameComponents count] > 1) {
		// if they entered multiple words (has a space), only add wildcard between
		likeString = [nameComponents componentsJoinedByString:@"%%"]; // '%%' escapes a percent
	} else {
		// if they entered one word, append wildcard to both sides
		likeString = [NSString stringWithFormat:@"%%%@%%", nonLikeString]; 
	}
	return likeString;
}

#pragma mark -
#pragma mark Singleton methods

+ (DatabaseHelper *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil)
			sharedInstance = [[DatabaseHelper alloc] init];
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

