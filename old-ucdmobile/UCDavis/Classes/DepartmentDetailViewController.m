//
//  DepartmentDetailViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/16/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "DepartmentDetailViewController.h"
#import "CMMapViewController.h"
#import "CourseListViewController.h"
#import "CMDepartment.h"
#import "CMBuilding.h"
#import "CMWebBrowserViewController.h"
#import "CourseListViewController.h"
#import "UIColor+CustomColors.h"

#define kDepartmentInfo 0
#define kDepartmentLocation 1
#define kCourses 2

static NSString *kLabelKey = @"labelKey";
static NSString *kSourceKey = @"sourceKey";

@implementation DepartmentDetailViewController

@synthesize department;
@synthesize dataSourceArray;

- (void)dealloc {
	[department release];
	[dataSourceArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = self.department.abbreviation;
	
	NSMutableArray *mutAr = [[NSMutableArray alloc] init];
	self.dataSourceArray = mutAr;
	[mutAr release];
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"url", nil], kLabelKey, [NSArray arrayWithObjects:self.department.url, nil], kSourceKey, nil]];
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"building", nil], kLabelKey, [NSArray arrayWithObjects:self.department.building.name, nil], kSourceKey, nil]];
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"courses", nil], kLabelKey, [NSArray arrayWithObjects:@"courses", nil], kSourceKey, nil]];

	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSourceArray count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.dataSourceArray objectAtIndex:section] objectForKey:kSourceKey] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *label = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kLabelKey] objectAtIndex:indexPath.row];
	NSString *source = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kSourceKey] objectAtIndex:indexPath.row];
	UITableViewCell *cell = nil;
	if([label isEqualToString:@"courses"]) {
		static NSString *CellIdentifierDefault = @"CellDefault";
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierDefault];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierDefault] autorelease];
		}
		
		cell.textLabel.text = label;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else {
		static NSString *CellIdentifier = @"Cell2";
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		}
		
		cell.textLabel.text = label;
		cell.detailTextLabel.text = source;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if(indexPath.row == 0) {
		if(indexPath.section == kDepartmentInfo) {
			CMWebBrowserViewController *webBrowserViewController = [[CMWebBrowserViewController alloc] initWithNibName:@"CMWebBrowserViewController" bundle:nil];
			webBrowserViewController.websiteURL = [NSURL URLWithString:[self.department.url stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
			webBrowserViewController.title = self.department.name;
			[self.navigationController pushViewController:webBrowserViewController animated:YES];
			[webBrowserViewController release];
		} else if(indexPath.section == kDepartmentLocation) {
			CMMapViewController *mapViewController = [[CMMapViewController alloc] initWithNibName:@"CMMapViewController" bundle:nil];
			[mapViewController performSelectorOnMainThread:@selector(addBuildingToMap:) withObject:self.department.building waitUntilDone:NO];
			[self.navigationController pushViewController:mapViewController animated:YES];
			[mapViewController release];
		} else if(indexPath.section == kCourses) {
			CourseListViewController *courseListViewController = [[CourseListViewController alloc] initWithNibName:@"CourseListViewController" bundle:nil];
			courseListViewController.department = self.department;
			[self.navigationController pushViewController:courseListViewController animated:YES];
			[courseListViewController release];		
		}
	}
}

@end

