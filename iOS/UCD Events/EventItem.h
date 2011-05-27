//
//  EventItem.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface EventItem : NSObject {
    NSDate *_date;   
}

-(id)initWithEventDictionary:(NSDictionary *) eventDictionary;

@property (nonatomic, retain) NSString *iD;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *locationId;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *description;

@end
