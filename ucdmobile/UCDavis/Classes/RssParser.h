//
//  RssParser.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/23/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RssParser : NSObject {
	NSURL *rssUrl;
	NSMutableArray *rssItems;
	NSXMLParser *xmlParser;
	
	// variables to use while we are streaming through document
	NSString *currentElementName;
	NSMutableDictionary *currentItem;
	NSMutableString *currentTitle;
	NSMutableString *currentLink;
	NSMutableString *currentDescription;
	NSMutableString *currentPubDate;
	//NSMutableString *currentImageURL;
}

@property (nonatomic, retain) NSURL *rssUrl;
@property (nonatomic, retain) NSMutableArray *rssItems;

- (id)initWithURL:(NSURL *)feedUrl;

@end
