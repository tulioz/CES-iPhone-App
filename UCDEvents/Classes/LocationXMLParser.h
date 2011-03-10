//
//  LocationXMLParser.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationItem.h"

@class LocationXMLParser;

@protocol LocationXMLParserDelegate<NSObject>

-(void)locationXMLParserDidFinishParsing:(LocationXMLParser *)locationXMLParser;
-(void)locationXMLParser:(LocationXMLParser *)locationXMLParser didFailWithError:(NSError *)error;

@end


@interface LocationXMLParser : NSObject<NSXMLParserDelegate> {
	NSMutableArray *locations;
	NSXMLParser *xmlParser;
	
	NSString *currentElementName;
	NSMutableDictionary *currentLocation;
	NSMutableString *currentID;
	NSMutableString *currentType;
	NSMutableString *currentName;
	NSMutableString *currentImageURL;
	NSMutableString *currentAddress;
	NSMutableString *currentCity;
	NSMutableString *currentCountry;
	NSMutableString *currentPhone;
	NSMutableString *currentMapsURL;
	
	id<LocationXMLParserDelegate> delegate;
}

@property (nonatomic, retain) id<LocationXMLParserDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *locations;

@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, copy) NSString *currentElementName;
@property (nonatomic, retain) NSMutableDictionary *currentLocation;
@property (nonatomic, retain) NSMutableString *currentName;
@property (nonatomic, retain) NSMutableString *currentID;
@property (nonatomic, retain) NSMutableString *currentType;
@property (nonatomic, retain) NSMutableString *currentImageURL;
@property (nonatomic, retain) NSMutableString *currentAddress;
@property (nonatomic, retain) NSMutableString *currentCity;
@property (nonatomic, retain) NSMutableString *currentCountry;
@property (nonatomic, retain) NSMutableString *currentPhone;
@property (nonatomic, retain) NSMutableString *currentMapsURL;

- (id)initWithContentsOfURL:(NSURL *)url;
-(void)parse;
-(NSArray *)locationItems;

@end