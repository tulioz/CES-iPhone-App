//
//  LocationListViewController.h
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "LocationDetailViewController.h"
//#import "SelectableImageItem.h"
#import "LocationJSONDataSource.h"
#import "LocationManager.h"
//#import <TTXMLParser.h>
//#import <TTXMLParser.h>
//#import <extThree20XML/TTXMLParser.h>
//#import "RestaurantModel.h"

@protocol LocationListViewControllerDelegate;

@interface LocationListViewController : TTTableViewController <TTSearchTextFieldDelegate>{
	NSString *_name;
	NSString *_url;
	
	CLLocation *lastLocation;
	
	id<LocationListViewControllerDelegate> _delegate;
}


-(id)initWithName:(NSString *)name;
-(id)initWithName:(NSString*)name url:(NSString *)url;

@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *categoryURL;
@property (nonatomic, retain) CLLocation * lastLocation;

@property (nonatomic, retain) id<LocationListViewControllerDelegate> delegate;

@end

@protocol LocationListViewControllerDelegate<NSObject>

-(void)locationListViewController:(LocationListViewController *)controller didSelectObject:(id)object;

@end