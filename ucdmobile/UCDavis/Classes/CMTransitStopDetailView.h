//
//  CMTransitStopDetailView.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTRoute;
@class GTStop;
@class UTPredictions;

@interface CMTransitStopDetailView : UITableViewController {
	NSOperationQueue *operationQueue;
	UIActivityIndicatorView *activityIndicatorView;
	
	NSString *calendar;
	GTRoute *route;
	GTStop *stop;
	UTPredictions *predictions;
	
	UIView *headerView;
	UIImageView *stopImageView;
	UILabel *stopTitleLabel;
	
	NSMutableArray *dataSourceArray;
}

@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, retain) NSString *calendar;
@property(nonatomic, retain) GTRoute *route;
@property(nonatomic, retain) GTStop *stop;
@property(nonatomic, retain) UTPredictions *predictions;

@property(nonatomic, retain) IBOutlet UIView *headerView;
@property(nonatomic, retain) IBOutlet UIImageView *stopImageView;
@property(nonatomic, retain) IBOutlet UILabel *stopTitleLabel;

@property(nonatomic, retain) NSMutableArray *dataSourceArray;

@end
