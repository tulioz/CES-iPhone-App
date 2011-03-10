//
//  CMBuilding.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/1/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CMBuilding : NSObject {
	NSInteger pk;
	NSString *name;
	NSNumber *latitude;
	NSNumber *longitude;
}

@property(nonatomic) NSInteger pk;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSNumber *latitude;
@property(nonatomic, retain) NSNumber *longitude;

- (id)initWithName:(NSString *)aName latitude:(NSNumber *)aLatitude longitude:(NSNumber *)aLongitude primaryKey:(NSInteger)primaryKey;

@end
