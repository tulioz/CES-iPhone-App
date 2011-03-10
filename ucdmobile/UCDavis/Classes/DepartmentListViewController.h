//
//  DepartmentListViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/16/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMCollege;

@interface DepartmentListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
	
	CMCollege *college;
	NSArray *departments;
}

@property(nonatomic, retain) CMCollege *college;
@property(nonatomic, retain) NSArray *departments;

@end
