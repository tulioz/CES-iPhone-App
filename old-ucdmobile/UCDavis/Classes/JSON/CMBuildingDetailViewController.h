//
//  CMBuildingDetailViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class CMBuilding;

@interface CMBuildingDetailViewController : UITableViewController <CLLocationManagerDelegate, UIActionSheetDelegate> {
	CMBuilding *building;
	
	NSOperationQueue *operationQueue;
	UIActivityIndicatorView *activityIndicatorView;
	UIView *headerView;
	UILabel *buildingNameLabel;
	UIImageView *buildingLocationImageView;	
	UIView *footerView;
	UIImageView *footerImageView;
	
	NSArray *rowLabels;
	
	CLLocationManager *locationManager;
	
	NSInteger selectedAction; // if the user selects an ActionSheet item
}

@property(nonatomic, retain) CMBuilding *building;

@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, retain) IBOutlet UIView *headerView;
@property(nonatomic, retain) IBOutlet UILabel *buildingNameLabel;
@property(nonatomic, retain) IBOutlet UIImageView *buildingLocationImageView;
@property(nonatomic, retain) IBOutlet UIView *footerView;
@property(nonatomic, retain) IBOutlet UIImageView *footerImageView;

@property(nonatomic, retain) NSArray *rowLabels;

@property(nonatomic, retain) CLLocationManager *locationManager;

@end
