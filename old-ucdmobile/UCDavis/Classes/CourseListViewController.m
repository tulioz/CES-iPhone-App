//
//  CourseListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/20/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "CourseListViewController.h"
#import "DatabaseHelper.h"
#import "CMDepartment.h"
#import "CourseDetailViewController.h"
#import "Course.h"

@implementation CourseListViewController

@synthesize department;
@synthesize courses;

- (void)dealloc {
	[department release];
	[courses release];
    [super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Courses";
	
	// fetch and numerically sort courses
	NSArray *unsortedCourses = [[DatabaseHelper sharedInstance] courseDictionariesByDepartment:department];
	NSSortDescriptor *sortDescriptorNumeric = [[NSSortDescriptor alloc] initWithKey:@"number.intValue" ascending:YES];
	self.courses = [unsortedCourses sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptorNumeric, nil]];
	[sortDescriptorNumeric release];
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
    return [self.courses count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *courseDictionary = [self.courses objectAtIndex:indexPath.row];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.department.abbreviation, [courseDictionary objectForKey:@"number"]];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", [courseDictionary objectForKey:@"title"], [courseDictionary objectForKey:@"count"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
	CourseDetailViewController *courseDetailViewController = [[CourseDetailViewController alloc] initWithNibName:@"CourseDetailViewController" bundle:nil];
	courseDetailViewController.department = self.department;
	courseDetailViewController.courseDictionary = [self.courses objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:courseDetailViewController animated:YES];
	[courseDetailViewController release];
}

@end
