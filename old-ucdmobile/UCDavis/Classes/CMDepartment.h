//
//  Department.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/15/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMBuilding;

@interface CMDepartment : NSObject {
	NSInteger pk;
	NSString *name;
	NSString *abbreviation;
	NSString *url;
	CMBuilding *building;
}

@property(nonatomic) NSInteger pk;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *abbreviation;
@property(nonatomic, retain) NSString *url;
@property(nonatomic, retain) CMBuilding *building;

- (id)initWithName:(NSString *)theName abbreviation:(NSString *)abbr departmentURL:(NSString *)deptUrl building:(CMBuilding *)theBuilding primaryKey:(NSInteger)primaryKey;

@end
