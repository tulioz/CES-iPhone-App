//
//  CampusResourcesViewController.h
//  UCDavis
//
//  Created by Fei Li on 2/15/10.
//  Copyright 2010 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CampusResourcesViewController : UITableViewController {
	NSMutableArray *dataSourceArray;
}

@property(nonatomic, retain) NSMutableArray *dataSourceArray;

- (BOOL)isPhone;

@end
