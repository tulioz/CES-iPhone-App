//
//  DepartmentAllListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CourseDepartmentListViewController.h"
#import "CourseListViewController.h"

@implementation CourseDepartmentListViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	CourseListViewController *courseListViewController = [[CourseListViewController alloc] initWithNibName:@"CourseListViewController" bundle:nil];
	courseListViewController.department = [self.departments objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:courseListViewController animated:YES];
	[courseListViewController release];		
}

@end

