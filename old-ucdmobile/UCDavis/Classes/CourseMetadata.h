//
//  Class.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/20/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CourseMetadata : NSObject {
	NSNumber *pk;
	NSString *title;
	NSString *number;
	NSString *units;
	NSString *description;
	
	NSArray *courses;
}

@property(nonatomic, copy) NSNumber *pk;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *units;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, retain) NSArray *courses;

- (id)initWithTitle:(NSString *)courseTitle number:(NSString *)courseNumber primaryKey:(NSNumber *)primaryKey;

@end
