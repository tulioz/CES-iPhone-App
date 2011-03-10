//
//  TicketPickerViewController.h
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "TicketPickerDataSource.h"
#import "PhotoTableLinkModel.h"

@interface TicketPickerViewController : UITableViewController {
	NSMutableArray *sourcesArray;
	PhotoTableLinkModel *currentLink;
}

@property (nonatomic, retain) PhotoTableLinkModel *currentLink;

@end
