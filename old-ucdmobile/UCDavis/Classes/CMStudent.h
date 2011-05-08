//
//  CMStudent.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMPerson.h"

@interface CMStudent : CMPerson {
	NSString *studentLevel;
	NSString *major;
}

@property (nonatomic, retain) NSString *studentLevel;
@property (nonatomic, retain) NSString *major;

- (id)initWithName:(NSString *)aName email:(NSString *)aEmail studentLevel:(NSString *)aStudentLevel major:(NSString *)aMajor primaryKey:(NSInteger)primaryKey;

@end
