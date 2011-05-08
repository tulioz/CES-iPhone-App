//
//  CMTransitStopSearchViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/19/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMDepartment;
@class MBProgressHUD;

@interface CMTransitStopSearchViewController : UITableViewController {
	NSString *calendar;
	NSString *searchString;
	NSArray *stops;
	
	NSOperationQueue *operationQueue;
	MBProgressHUD *progressHud;
}

@property(nonatomic, retain) NSString *calendar;
@property(nonatomic, retain) NSString *searchString;
@property(nonatomic, retain) NSArray *stops;

@end
