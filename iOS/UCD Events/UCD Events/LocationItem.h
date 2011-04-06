//
//  LocationItem.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Three20/Three20.h"

@interface LocationItem : NSObject {

}

-(id)initWithLocationDictionary:(NSDictionary *) locationDictionary;

@property (nonatomic, retain) NSString *iD;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *hours;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *mapsURL;
@property (nonatomic) CLLocationDistance *distance;

@end
