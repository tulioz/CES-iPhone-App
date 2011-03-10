//
//  DirectoryDetailViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/16/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class CMPerson;

@interface DirectoryDetailViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
	CMPerson *person;
	
	NSMutableArray *dataSourceArray;
	
	UIView *headerView;
	UILabel *headerPersonLabel;
}

@property(nonatomic, retain) CMPerson *person;
@property(nonatomic, retain) NSMutableArray *dataSourceArray;

@property(nonatomic, retain) IBOutlet UILabel *headerPersonLabel;
@property(nonatomic, retain) IBOutlet UIView *headerView;

@end
