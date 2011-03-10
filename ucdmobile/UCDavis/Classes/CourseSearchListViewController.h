//
//  CourseSearchListViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/4/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMDepartment;
@class MBProgressHUD;

@interface CourseSearchListViewController : UITableViewController {
	NSString *searchString;
	NSArray *courses;

	NSOperationQueue *operationQueue;
	MBProgressHUD *progressHud;
}

@property(nonatomic, retain) NSString *searchString;
@property(nonatomic, retain) NSArray *courses;

@end
