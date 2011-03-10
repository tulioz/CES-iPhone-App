//
//  CMCollege.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/14/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CMCollege : NSObject {
	NSInteger pk;
	NSString *name;
}

@property(nonatomic) NSInteger pk;
@property(nonatomic, retain) NSString *name;

- (id)initWithName:(NSString *)theName primaryKey:(NSInteger)primaryKey;

@end
