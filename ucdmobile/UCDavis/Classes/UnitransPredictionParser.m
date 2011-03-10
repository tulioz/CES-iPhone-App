//
//  UnitransPredictionParser.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UnitransPredictionParser.h"
#import "UTPrediction.h"

@interface UnitransPredictionParser ()

@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) UTPrediction *currentPrediction;
@property (nonatomic) Boolean inPredictions;
@property (nonatomic) Boolean inDirection;
@property (nonatomic) Boolean inPrediction;

- (void)parseXMLFile;

@end

@implementation UnitransPredictionParser

@synthesize url;
@synthesize routeTag;
@synthesize directionTitle;
@synthesize predictions;
@synthesize xmlParser;
@synthesize currentPrediction;
@synthesize inPredictions;
@synthesize inDirection;
@synthesize inPrediction;

- (void) dealloc {
	[url release];
	[routeTag release];
	[directionTitle release];
	[predictions release];
	[xmlParser release];
	[currentPrediction release];
	[super dealloc];
}


- (id)initWithURL:(NSURL *)feedUrl {
	if(self = [super init]) {
		self.url = feedUrl;
		[self parseXMLFile];
	}
	return self;
}

- (void)parseXMLFile {
	NSMutableArray *mutAr = [[NSMutableArray alloc] init];
	self.predictions = mutAr;
	[mutAr release];
	
	NSXMLParser *xmlParserWithUrl = [[NSXMLParser alloc] initWithContentsOfURL:self.url];
	self.xmlParser = xmlParserWithUrl;
	[xmlParserWithUrl release];
	
	[self.xmlParser setDelegate:self];
	
	[self.xmlParser setShouldProcessNamespaces:NO];
	[self.xmlParser setShouldReportNamespacePrefixes:NO];
	[self.xmlParser setShouldResolveExternalEntities:NO];
	
	[self.xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//NSLog(@"found this element: %@", elementName);
	
	if([elementName isEqualToString:@"predictions"]) {
		inPredictions = YES;
		self.routeTag = [attributeDict objectForKey:@"routeTag"];
	} else if([elementName isEqualToString:@"direction"]) {
		inDirection = YES;
	} else if([elementName isEqualToString:@"prediction"]) {
		inPrediction = YES;
		UTPrediction *newPrediction = [[UTPrediction alloc] init];
		self.currentPrediction = newPrediction;
		[newPrediction release];
		
		currentPrediction.seconds = [[attributeDict objectForKey:@"seconds"] integerValue];
		currentPrediction.minutes = [[attributeDict objectForKey:@"minutes"] integerValue];
		currentPrediction.epochTime = [[attributeDict objectForKey:@"epochTime"] integerValue];
		currentPrediction.vehicleId = [[attributeDict objectForKey:@"vehicle"] integerValue];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	if([elementName isEqualToString:@"predictions"]) {
		inPredictions = NO;
	} else if([elementName isEqualToString:@"direction"]) {
		inDirection = NO;
	} else if([elementName isEqualToString:@"prediction"]) {
		inPrediction = NO;
		[self.predictions addObject:self.currentPrediction];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	//NSLog(@"items array has %d items", [self.rssItems count]);
}
@end
