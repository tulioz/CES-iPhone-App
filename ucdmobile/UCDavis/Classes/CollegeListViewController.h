//
//  DepartmentListViewController.h
//  Departments
//
//  Created by Sunny Dhillon on 10/11/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollegeListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {   
	NSArray *colleges;
}

@property(nonatomic, retain) NSArray *colleges;

@end
