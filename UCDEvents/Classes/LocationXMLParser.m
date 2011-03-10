//
//  LocationXMLParser.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationXMLParser.h"

@implementation LocationXMLParser

@synthesize xmlParser;
@synthesize currentElementName;
@synthesize currentLocation;
@synthesize currentName;
@synthesize currentID;
@synthesize currentType;
@synthesize currentImageURL;
@synthesize currentAddress;
@synthesize currentCity;
@synthesize currentCountry;
@synthesize currentPhone;
@synthesize currentMapsURL;

@synthesize locations;

@synthesize delegate;

-(id)initWithContentsOfURL:(NSURL *)url {
	if (self = [super init]) {
		NSMutableArray *aMutableArray = [[NSMutableArray alloc] init];
		self.locations = aMutableArray;
		[aMutableArray release];
		
		NSXMLParser *xmlParserWithURL = [[NSXMLParser alloc] initWithContentsOfURL:url];
		self.xmlParser = xmlParserWithURL;
		[xmlParserWithURL release];
		
		[self.xmlParser setDelegate:self];
		[self.xmlParser setShouldProcessNamespaces:NO];
		[self.xmlParser setShouldReportNamespacePrefixes:NO];
		[self.xmlParser setShouldResolveExternalEntities:NO];
	}
	
	return self;
}

-(void)parse {	
	[self.xmlParser parse];
//	[self sectionTheLocations];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	//	[UIAlertHelper networkErrorAlert];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	self.currentElementName = elementName;
	
	if ([elementName isEqualToString:@"location"]) {
		NSMutableDictionary *locationDictionary = [[NSMutableDictionary alloc] init];
		self.currentLocation = locationDictionary;
		[locationDictionary release];
		
		NSMutableString *aMutableString = [[NSMutableString alloc] init];
		self.currentName = aMutableString;
		[aMutableString release];
		
		aMutableString = [[NSMutableString alloc] init];
		self.currentType = aMutableString;
		[aMutableString release];
		
		aMutableString = [[NSMutableString alloc] init];
		self.currentID = aMutableString;
		[aMutableString release];
		
		aMutableString = [[NSMutableString alloc] init];
		self.currentImageURL = aMutableString;
		[aMutableString release];
		
		aMutableString = [[NSMutableString alloc] init];
		self.currentAddress = aMutableString;
		[aMutableString release];
		
		aMutableString = [[NSMutableString alloc] init];
		self.currentCity = aMutableString;
		[aMutableString release];
		
		aMutableString = [[NSMutableString alloc] init];
		self.currentCountry = aMutableString;
		[aMutableString release];
		
		aMutableString = [[NSMutableString alloc] init];
		self.currentPhone = aMutableString;
		[aMutableString release];
		
		aMutableString = [[NSMutableString alloc] init];
		self.currentMapsURL = aMutableString;
		[aMutableString release];
	}
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	NSLog(@"Ending element: %@", elementName);
	
	if ([elementName isEqualToString:@"location"]) {
		[self.currentLocation setObject:self.currentName forKey:@"name"];
		[self.currentLocation setObject:self.currentID forKey:@"id"];
		[self.currentLocation setObject:self.currentType forKey:@"type"];
		[self.currentLocation setObject:self.currentAddress forKey:@"address"];
		[self.currentLocation setObject:self.currentCity forKey:@"city"];
		[self.currentLocation setObject:self.currentCountry	forKey:@"country"];
		[self.currentLocation setObject:self.currentPhone forKey:@"phone"];
		[self.currentLocation setObject:self.currentMapsURL forKey:@"mapsURL"];
		[self.currentLocation setObject:self.currentImageURL forKey:@"imageURL"];
		
		[self.locations addObject:self.currentLocation];
	}
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if ([self.currentElementName isEqualToString:@"name"]) {
		[self.currentName appendString:string];
	} else if ([self.currentElementName isEqualToString:@"id"]) {
		[self.currentID appendString:string];
	} else if ([self.currentElementName isEqualToString:@"type"]) {
		[self.currentType appendString:string];
	} else if ([self.currentElementName isEqualToString:@"address"]) {
		[self.currentAddress appendString:string];
	} else if ([self.currentElementName isEqualToString:@"city"]) {
		[self.currentCity appendString:string];
	} else if ([self.currentElementName isEqualToString:@"country"]) {
		[self.currentCountry appendString:string];
	} else if ([self.currentElementName isEqualToString:@"phone"]) {
		[self.currentPhone appendString:string];
	} else if ([self.currentElementName isEqualToString:@"mapsURL"]) {
		[self.currentMapsURL appendString:string];
	} else if ([self.currentElementName isEqualToString:@"imageURL"]) {
		[self.currentImageURL appendString:string];
	}
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
	if (delegate && [delegate respondsToSelector:@selector(locationXMLParserDidFinishParsing:)]) {
		[delegate locationXMLParserDidFinishParsing:self];
	}
}

-(NSArray *) locationItems {
	NSMutableArray *locationItems = [NSMutableArray arrayWithCapacity:locations.count];
	
	for (NSDictionary *location in locations) {
		LocationItem *currentItem = [[LocationItem alloc] init];
		
		currentItem.iD = [location objectForKey:@"id"];
		currentItem.name = [location objectForKey:@"name"];
		currentItem.type = [location objectForKey:@"type"];
		currentItem.address = [location objectForKey:@"address"];
		currentItem.city = [location objectForKey:@"city"];
		currentItem.country = [location objectForKey:@"country"];
		currentItem.phone = [location objectForKey:@"phone"];
		currentItem.mapsURL = [location objectForKey:@"mapsURL"];
		currentItem.imageURL = [location objectForKey:@"imageURL"];
		
		[locationItems addObject:currentItem];
		[currentItem release];
	}
	
	return locationItems;
}

-(void)dealloc {
	[locations release];
	[xmlParser release];
	[currentElementName release];
	
	[super dealloc];
}


@end
