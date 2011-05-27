//
//  OfferItem.h
//  UCD Events
//
//  Created by William Binns-Smith on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "Settings.h"

@interface OfferItem : NSObject {
    
}

-(id)initWithOfferDictionary:(NSDictionary *) offerDictionary;

@property (nonatomic, retain) NSString *iD;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *locationId;
@property (nonatomic, retain) NSString *description;

@end
