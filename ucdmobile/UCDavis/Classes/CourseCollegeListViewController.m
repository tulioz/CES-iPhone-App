//
//  CourseCollegeListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/25/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "CourseCollegeListViewController.h"
#import "CourseDepartmentListViewController.h"
#import "CMCollege.h"
#import "CourseSearchListViewController.h"
#import "DatabaseHelper.h"

#define kPickerViewOffScreen CGRectMake(0, 416, 325, 250)
#define kPickerViewOnScreen CGRectMake(0, 200, 325, 250)

@interface CourseCollegeListViewController ()

- (void)didSelectQuarter:(id)sender;

@end

@implementation CourseCollegeListViewController

@synthesize tableView;
@synthesize colleges;
@synthesize pickerDataArray;
@synthesize pickerView;

- (void)dealloc {
	[tableView release];
	[colleges release];
	[pickerDataArray release];
    [super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// fetch colleges
	self.colleges = [[DatabaseHelper sharedInstance] colleges];
	
	// set up picker array
	self.pickerDataArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"Winter", nil], [NSArray arrayWithObjects:@"2010", nil], nil];
	
	// set up right button to let them change the quarters
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"WQ 10" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectQuarter:)];
	self.navigationItem.rightBarButtonItem = barButton;
	[barButton release];	
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
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMCollege *college = [self.colleges objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"College";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    cell.textLabel.text = college.name;
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	// Navigation logic may go here. Create and push another view controller.
	CourseDepartmentListViewController *departmentListViewController = [[CourseDepartmentListViewController alloc] initWithNibName:@"CourseDepartmentListViewController" bundle:nil];
	CMCollege *college = [self.colleges objectAtIndex:indexPath.row];
	departmentListViewController.college = college;
	[self.navigationController pushViewController:departmentListViewController animated:YES];
	[departmentListViewController release];
}

#pragma mark -
#pragma mark Search Delegate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:NO animated:YES];
	[searchBar resignFirstResponder];
	// limit searches to >= 3 characters to help on db load
	if([searchBar.text length] < 3) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Search String" message:@"Please enter a longer query." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		return;
	}	
	// send them to view the courses
	CourseSearchListViewController *courseListViewController = [[CourseSearchListViewController alloc] initWithNibName:@"CourseSearchListViewController" bundle:nil];
	courseListViewController.searchString = searchBar.text;
	[self.navigationController pushViewController:courseListViewController animated:YES];
	[courseListViewController release];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:NO animated:YES];
	
	[searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)aPickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[pickerDataArray objectAtIndex:component] objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)aPickerView numberOfRowsInComponent:(NSInteger)component{
	return [[self.pickerDataArray objectAtIndex:component] count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)aPickerView {
	return [self.pickerDataArray count];
}

#pragma mark -
#pragma mark Private methods

- (void)didSelectQuarter:(id)sender {
	[UIView beginAnimations:@"CalendarTransition" context:nil];
	[UIView setAnimationDuration:0.3];
	if(self.pickerView.frame.origin.y < kPickerViewOffScreen.origin.y) { // on screen
		self.pickerView.frame = kPickerViewOffScreen;
		self.navigationItem.rightBarButtonItem.title = @"WQ 10";
	} else { // off screen
		self.pickerView.frame = kPickerViewOnScreen;
		self.navigationItem.rightBarButtonItem.title = @"Done";
	}
	[UIView commitAnimations];
}


@end

