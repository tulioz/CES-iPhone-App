//
//  DepartmentListViewController.m
//  Departments
//
//  Created by Sunny Dhillon on 10/11/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "CollegeListViewController.h"
#import "DatabaseHelper.h"
#import "CMCollege.h"

@implementation CollegeListViewController

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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

