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
#import "LocationIndexJSONDataSource.h"

@protocol LocationListViewControllerDelegate;

@interface LocationListViewController : TTTableViewController <TTSearchTextFieldDelegate>{
	NSString *_name;
	NSString *_url;
    
    NSString *_typeId;
	
	id<LocationListViewControllerDelegate> _delegate;
}

-(id)initWithName:(NSString*)name typeId:(NSInteger *)typeId;

@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *categoryURL;

@property (nonatomic, retain) id<LocationListViewControllerDelegate> delegate;

@end

@protocol LocationListViewControllerDelegate<NSObject>

-(void)locationListViewController:(LocationListViewController *)controller didSelectObject:(id)object;

@end