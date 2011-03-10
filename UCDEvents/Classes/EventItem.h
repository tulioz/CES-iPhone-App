//
//  EventItem.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationItem.h"

@interface EventItem : NSObject {

}

@property (nonatomic, retain) NSString *iD;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) LocationItem *eventLocation;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSDate *date;


@end
