//
//  CMStaff.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMPerson.h"

@interface CMStaff : CMPerson {
	NSString *address;
	NSString *title;
	NSString *phone;
	NSString *department;
	NSString *website;
}

@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *department;
@property (nonatomic, retain) NSString *website;

- (id)initWithName:(NSString *)aName email:(NSString *)aEmail address:(NSString *)aAddress title:(NSString *)aTitle phone:(NSString *)aPhone department:(NSString *)dept website:(NSString *)aWebsite primaryKey:(NSInteger)primaryKey;

@end
