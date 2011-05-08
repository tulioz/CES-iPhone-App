//
//  CourseDetailViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/22/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMDepartment;

@interface CourseDetailViewController : UITableViewController {
	CMDepartment *department;
	
	NSDictionary *courseDictionary;
	NSArray *courses;
	
	NSMutableArray *dataSourceArray;
	
	UIView *headerView;
	UILabel *headerCourseTitleLabel;
}

@property(nonatomic, retain) CMDepartment *department;
@property(nonatomic, retain) NSDictionary *courseDictionary;
@property(nonatomic, retain) NSArray *courses;
@property(nonatomic, retain) NSMutableArray *dataSourceArray;
@property(nonatomic, retain) IBOutlet UIView *headerView;
@property(nonatomic, retain) IBOutlet UILabel *headerCourseTitleLabel;

@end
