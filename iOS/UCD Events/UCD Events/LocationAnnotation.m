//
//  LocationAnnotation.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationAnnotation.h"


@implementation LocationAnnotation

@synthesize location = _location;
@synthesize coordinate = _coordinate;

-(NSString *)subtitle {
    return [NSString stringWithFormat:@"%@", self.location.category];
}

-(NSString *)title {
    return [NSString stringWithFormat:@"%@", self.location.name];
}

//+(id)annotationWithLocationItem:(LocationItem *)locationItem {
//    return [[[[self class] alloc] initWithLocationItem:locationItem]];
//}

-(id)initWithLocationItem:(LocationItem *) locationItem {
    if (self = [super init]) {
        self.location = locationItem;
        self.coordinate = CLLocationCoordinate2DMake([self.location.latitude doubleValue], [self.location.longitude doubleValue]);        
    }
}

@end
