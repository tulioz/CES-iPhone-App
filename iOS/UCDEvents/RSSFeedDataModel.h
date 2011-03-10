#import "RSSFeedParser.h"
#import "Three20/Three20.h"

@interface RSSFeedDataModel : TTModel<RSSFeedParserDelegate> {
	RSSFeedParser *parser;
	BOOL done;
	BOOL loading;
}

- (NSArray *)modelItems;

@end