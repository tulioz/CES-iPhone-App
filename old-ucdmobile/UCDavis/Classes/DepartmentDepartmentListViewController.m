//
//  DepartmentDepartmentListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/26/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "DepartmentDepartmentListViewController.h"
#import "DepartmentDetailViewController.h"
#import "CMCollege.h"

@implementation DepartmentDepartmentListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
    // Navigation logic may go here. Create and push another view controller.
	DepartmentDetailViewController *departmentDetailViewController = [[DepartmentDetailViewController alloc] initWithNibName:@"DepartmentDetailViewController" bundle:nil];
	departmentDetailViewController.department = [super.departments objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:departmentDetailViewController animated:YES];
	[departmentDetailViewController release];
}

@end
