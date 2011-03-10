//
//  DatabaseHelper.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/1/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class CMCollege;
@class CMDepartment;
@class Course;

@interface DatabaseHelper : NSObject {
	FMDatabase *db;
}

@property (nonatomic, retain) FMDatabase *db;

+ (DatabaseHelper *)sharedInstance;

- (NSArray *)buildings;

- (NSArray *)colleges;

- (NSArray *)departmentsByCollege:(CMCollege *)college;
- (CMDepartment *)departmentById:(NSInteger)pk;

- (NSArray *)coursesByNumber:(NSString *)number department:(CMDepartment *)department;
- (NSArray *)courseDictionariesByDepartment:(CMDepartment *)department;
- (NSDictionary *)courseMetadataDictionaryByDepartment:(CMDepartment *)dept course:(Course *)course;
- (NSArray *)courseDictionariesLikeName:(NSString *)name;
- (NSArray *)courseTimesByCourse:(Course *)course;
- (NSArray *)courseTextbookDictionariesByDepartment:(CMDepartment *)dept course:(Course *)course;

- (NSArray *)peopleWithNameLike:(NSString *)name;

@end
