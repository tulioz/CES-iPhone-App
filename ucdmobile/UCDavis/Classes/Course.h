//
//  Course.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/28/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Course : NSObject {
	NSInteger pk;
	NSString *title;
	NSString *number;
	NSString *crn;
	NSString *type;
	NSString *section;
	NSString *units;
	NSString *instructor;
	NSString *seats;
	
	NSArray *courseTimes;
	NSArray *courseTextbooks;
}

@property(nonatomic) NSInteger pk;
@property(nonatomic, retain) NSString *crn;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *number;
@property(nonatomic, retain) NSString *type;
@property(nonatomic, retain) NSString *section;
@property(nonatomic, retain) NSString *units;
@property(nonatomic, retain) NSString *instructor;
@property(nonatomic, retain) NSString *seats;
@property(nonatomic, retain) NSArray *courseTimes;
@property(nonatomic, retain) NSArray *courseTextbooks;

- (id)initWithTitle:(NSString *)aTitle number:(NSString *)courseNumber crn:(NSString *)aCrn type:(NSString *)aType section:(NSString *)sec units:(NSString *)numUnits instructor:(NSString*)inst seats:(NSString *)occ primaryKey:(NSInteger)primaryKey;

@end
