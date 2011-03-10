//
//  CourseSearchListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/4/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "CourseSearchListViewController.h"
#import "CMDepartment.h"
#import "DatabaseHelper.h"
#import "CourseDetailViewController.h"
#import "MBProgressHud.h"

@interface CourseSearchListViewController (Private)

- (void)synchronousLoadCourses;
- (void)didFinishLoadingCourses;

@end


@implementation CourseSearchListViewController

@synthesize searchString;
@synthesize courses;

- (void)dealloc {
	[operationQueue release];
	[searchString release];
	[courses release];
    [super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Courses";
	
	// set up operation queue for thread fetching of classes
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];
	
	// loading the names might take a while
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadCourses) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	
	progressHud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:progressHud];
	progressHud.labelText = [NSString stringWithFormat:@"Finding courses..."];
	[progressHud show:YES];
	
}

- (void)synchronousLoadCourses {
	// fetch and numerically sort courses
	NSArray *unsortedCourses = [[DatabaseHelper sharedInstance] courseDictionariesLikeName:self.searchString];
	NSSortDescriptor *sortDescriptorNumeric = [[NSSortDescriptor alloc] initWithKey:@"number.intValue" ascending:YES];
	self.courses = [unsortedCourses sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptorNumeric, nil]];
	[sortDescriptorNumeric release];
	[self performSelectorOnMainThread:@selector(didFinishLoadingCourses) withObject:nil waitUntilDone:NO];
}

- (void)didFinishLoadingCourses {
	[self.tableView reloadData];
	
	[progressHud removeFromSuperview];
	[progressHud release];
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
	CMDepartment *department = [courseDictionary objectForKey:@"department"];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", department.abbreviation, [courseDictionary objectForKey:@"number"]];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", [courseDictionary objectForKey:@"title"], [courseDictionary objectForKey:@"count"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
	CourseDetailViewController *courseDetailViewController = [[CourseDetailViewController alloc] initWithNibName:@"CourseDetailViewController" bundle:nil];
	NSDictionary *courseDictionary = [self.courses objectAtIndex:indexPath.row];
	CMDepartment *department = [courseDictionary objectForKey:@"department"];
	courseDetailViewController.department = department;
	courseDetailViewController.courseDictionary = courseDictionary;
	[self.navigationController pushViewController:courseDetailViewController animated:YES];
	[courseDetailViewController release];
}

@end
