//
//  CourseCollegeListViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/25/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCollegeListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
	
	UITableView *tableView;

	NSArray *colleges;
	
	UIPickerView *pickerView;
	NSArray *pickerDataArray;
}
@property(nonatomic, retain) IBOutlet UITableView *tableView;

@property(nonatomic, retain) NSArray *colleges;

@property(nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property(nonatomic, retain) NSArray *pickerDataArray;

@end
