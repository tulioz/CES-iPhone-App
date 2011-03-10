//
//  DepartmentCollegeListViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/13/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartmentCollegeListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {   
	NSArray *colleges;
}

@property(nonatomic, retain) NSArray *colleges;

@end
