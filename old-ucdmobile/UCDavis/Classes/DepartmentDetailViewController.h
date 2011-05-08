//
//  DepartmentDetailViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/16/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMDepartment;

@interface DepartmentDetailViewController : UITableViewController {
	CMDepartment *department;
	NSMutableArray *dataSourceArray;
}

@property(nonatomic, retain) CMDepartment *department;
@property(nonatomic, retain) NSMutableArray *dataSourceArray;

@end
