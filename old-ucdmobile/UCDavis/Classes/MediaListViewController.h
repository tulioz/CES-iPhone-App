//
//  MediaListViewController.h
//  UCDavis
//
//  Created by Fei Li on 11/22/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class LoadingViewController;
@class MBProgressHUD;

@interface MediaListViewController : UITableViewController {
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