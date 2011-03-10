//
//  CourseListViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/20/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMDepartment;

@interface CourseListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
	CMDepartment *department;
	
	NSArray *courses;
}

@property(nonatomic, retain) CMDepartment *department;
@property(nonatomic, retain) NSArray *courses;

@end
