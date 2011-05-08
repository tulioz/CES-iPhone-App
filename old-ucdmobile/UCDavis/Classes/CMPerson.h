//
//  CMPerson.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CMPerson : NSObject {
	NSInteger pk;
	NSString *name;
	NSString *email;
}

@property(nonatomic) NSInteger pk;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *email;
@property(nonatomic, readonly) NSString *firstName;
@property(nonatomic, readonly) NSString *lastName;
@property(nonatomic, readonly) NSString *lastNameInitial;

- (id)initWithName:(NSString *)aName email:(NSString *)aEmail primaryKey:(NSInteger)primaryKey;

@end
