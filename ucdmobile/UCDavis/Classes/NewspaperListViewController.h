//
//  NewsListViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface NewspaperListViewController : UITableViewController {
	//LoadingViewController *loadingViewController;
	NSOperationQueue *operationQueue;
	
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *dateLabel;
	IBOutlet UILabel *descriptionLabel;	
	
	NSArray *stories;	
	NSURL *feedURL;
	NSString *feedName;	
	
	MBProgressHUD *progressHud;
}

@property (nonatomic, retain) NSArray *stories;
@property (nonatomic, retain) NSURL *feedURL;
@property (nonatomic, retain) NSString *feedName;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;

@end
