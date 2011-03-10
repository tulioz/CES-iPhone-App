//
//  InformationBodyViewController.h
//  UCDavis
//
//  Created by Fei Li on 10/18/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface InformationTeamViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
	NSMutableArray *dataSourceArray;
}

@property(nonatomic, retain) NSMutableArray *dataSourceArray;

@end
