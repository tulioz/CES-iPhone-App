//
//  CourseTime.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/28/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBuilding;

@interface CourseTime : NSObject {
	NSInteger pk;
	NSString *days;
	NSString *time;
	CMBuilding *building;
	NSString *buildingName;
	NSString *room;
}

@property(nonatomic) NSInteger pk;
@property(nonatomic, retain) NSString *days;
@property(nonatomic, retain) NSString *time;
@property(nonatomic, retain) CMBuilding *building;
@property(nonatomic, retain) NSString *buildingName;
@property(nonatomic, retain) NSString *room;

- (id)initWithDays:(NSString *)theDays time:(NSString *)aTime buildingName:(NSString *)aBuildingName room:(NSString *)aRoom  primaryKey:(NSInteger)primaryKey;

@end
