//
//  EventListViewController.h
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "EventDetailViewController.h"
//#import "SelectableImageItem.h"
#import "EventJSONDataSource.h"
//#import <TTXMLParser.h>
//#import <TTXMLParser.h>
//#import <extThree20XML/TTXMLParser.h>
//#import "RestaurantModel.h"
#import "Settings.h"

@interface EventListViewController : TTTableViewController {
	NSString *_name;
	NSString *_url;
}


-(id)initWithName:(NSString *)name;
-(id)initWithName:(NSString*)name url:(NSString *)url;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *categoryURL;


@end
