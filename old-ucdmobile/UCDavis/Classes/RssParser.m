//
//  RssParser.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/23/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "RSSParser.h"
#import "UIAlertHelper.h"

@interface RssParser ()

@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, copy) NSString *currentElementName;
@property (nonatomic, retain) NSMutableDictionary *currentItem;
@property (nonatomic, retain) NSMutableString *currentTitle;
@property (nonatomic, retain) NSMutableString *currentLink;
@property (nonatomic, retain) NSMutableString *currentDescription;
@property (nonatomic, retain) NSMutableString *currentPubDate;
//@property (nonatomic, retain) NSMutableString *currentImage;

- (void)parseXMLFile;

@end


@implementation RssParser

@synthesize rssUrl;
@synthesize rssItems;
@synthesize xmlParser;
@synthesize currentElementName;
@synthesize currentItem;
@synthesize currentTitle;
@synthesize currentLink;
@synthesize currentDescription;
@synthesize currentPubDate;

- (void) dealloc {
	[rssUrl release];
	[rssItems release];
	[xmlParser release];
	[currentElementName release];
	[currentItem release];
	[super dealloc];
}


- (id)initWithURL:(NSURL *)feedUrl {
	if(self = [super init]) {
		self.rssUrl = feedUrl;
		[self parseXMLFile];
	}
	return self;
}

- (void)parseXMLFile {
	NSMutableArray *mutAr = [[NSMutableArray alloc] init];
	self.rssItems = mutAr;
	[mutAr release];
	
	NSXMLParser *xmlParserWithUrl = [[NSXMLParser alloc] initWithContentsOfURL:self.rssUrl];
	self.xmlParser = xmlParserWithUrl;
	[xmlParserWithUrl release];
	
	[self.xmlParser setDelegate:self];

	[self.xmlParser setShouldProcessNamespaces:NO];
	[self.xmlParser setShouldReportNamespacePrefixes:NO];
	[self.xmlParser setShouldResolveExternalEntities:NO];
	
	[self.xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	[UIAlertHelper networkErrorAlert];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	self.currentElementName = elementName;
	
	if ([elementName isEqualToString:@"item"]) {
		// found an item block
		NSMutableDictionary *itemDict = [[NSMutableDictionary alloc] init];
		self.currentItem = itemDict;
		[itemDict release];
		NSMutableString *mutString = [[NSMutableString alloc] init];
		self.currentTitle = mutString;
		[mutString release];
		mutString = [[NSMutableString alloc] init];
		self.currentPubDate = mutString;
		[mutString release];
		mutString = [[NSMutableString alloc] init];
		self.currentDescription = mutString;
		[mutString release];
		mutString = [[NSMutableString alloc] init];
		self.currentLink = mutString;
		[mutString release];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// finished, store in dictionary
		[self.currentItem setObject:self.currentTitle forKey:@"title"];
		[self.currentItem setObject:self.currentLink forKey:@"link"];
		[self.currentItem setObject:self.currentDescription forKey:@"description"];
		[self.currentItem setObject:self.currentPubDate forKey:@"pubDate"];
		// store in rss item array
		[self.rssItems addObject:self.currentItem];
		//NSLog(@"adding item: %@", self.currentTitle);
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item
	if ([self.currentElementName isEqualToString:@"title"]) {
		[self.currentTitle appendString:string];
	} else if ([self.currentElementName isEqualToString:@"link"]) {
		[self.currentLink appendString:string];
	} else if ([self.currentElementName isEqualToString:@"description"]) {
		[self.currentDescription appendString:string];
	} else if ([self.currentElementName isEqualToString:@"pubDate"]) {
		[self.currentPubDate appendString:string];
	} 
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	//NSLog(@"items array has %d items", [self.rssItems count]);
}

@end
