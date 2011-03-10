//
//  RSSFeedDataSource.h
//  TTRSS
//
//  Created by William Binns-Smith on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "RSSFeedDataModel.h"


@interface RSSFeedDataSource : TTListDataSource {
	RSSFeedDataModel *dataModel;
}

//- (id)initWithFeedURL:(NSString*) feedURL

@end
