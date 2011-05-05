//
//  OffersJSONDataModel.h
//  UCD Events
//
//  Created by William Binns-Smith on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "extThree20JSON/extThree20JSON.h"
#import "Settings.h"

#import "OfferItem.h"

@interface OffersJSONDataModel : TTURLRequestModel {
    NSMutableArray *_offers;
    BOOL _finished;
}

@property (nonatomic, readonly, retain) NSMutableArray *offers;
@property (nonatomic, readonly) BOOL finished;
@property (nonatomic) NSUInteger size;

-(NSString *)getURL;

@end
