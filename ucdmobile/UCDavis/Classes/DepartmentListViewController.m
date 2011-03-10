//
//  DepartmentListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/16/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "DepartmentListViewController.h"
#import "DepartmentDetailViewController.h"
#import "DepartmentListViewCell.h"
#import "CMCollege.h"
#import "CMDepartment.h"
#import "DatabaseHelper.h"

@implementation DepartmentListViewController

@synthesize college;
@synthesize departments;

- (void)dealloc {
	[college release];
	[departments release];
    [super dealloc];
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Departments";
	
	// fetch departments
	self.departments = [[DatabaseHelper sharedInstance] departmentsByCollege:self.college];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.departments count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMDepartment *department = [self.departments objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"DepartmentListViewCell";
    
    DepartmentListViewCell *cell = (DepartmentListViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DepartmentListViewCell" owner:nil options:nil];
		for(id currentObject in topLevelObjects) {
			if([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (DepartmentListViewCell *) currentObject;
				break;
			}
		}
	}
	cell.abbreviationLabel.text = department.abbreviation;
	cell.departmentLabel.text = department.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
