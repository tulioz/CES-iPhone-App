//
//  DepartmentCollegeListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/13/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "DepartmentCollegeListViewController.h"
#import "DepartmentDepartmentListViewController.h"
#import "CMCollege.h"
#import "DatabaseHelper.h"

@implementation DepartmentCollegeListViewController

@synthesize colleges;

- (void)dealloc {
	[colleges release];
    [super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// fetch colleges
	self.colleges = [[DatabaseHelper sharedInstance] colleges];
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
    return [self.colleges count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMCollege *college = [self.colleges objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"College";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    cell.textLabel.text = college.name;
    return cell;
}

// only implement the selection
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	// Navigation logic may go here. Create and push another view controller.
	DepartmentDepartmentListViewController *departmentListViewController = [[DepartmentDepartmentListViewController alloc] initWithNibName:@"DepartmentListViewController" bundle:nil];
	CMCollege *college = [self.colleges objectAtIndex:indexPath.row];
	departmentListViewController.college = college;
	[self.navigationController pushViewController:departmentListViewController animated:YES];
	[departmentListViewController release];
}

@end
