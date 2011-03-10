//
//  RootViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DepartmentRootViewController;
@class NewspaperRootViewController;
@class MapRootViewController;
@class CalendarRootViewController;
@class DirectoryRootViewController;
@class AthleticsRootViewController;
@class MediaRootViewController;
@class CourseRootViewController;
@class WebBrowserRootViewController;
@class TransitRootViewController;
@class CampusResourcesRootViewController;

@interface RootViewController : UIViewController<UISearchBarDelegate> {
	IBOutlet UISearchBar *searchBar;
	
	DepartmentRootViewController *departmentRootViewController;
	NewspaperRootViewController *newspaperRootViewController;
	MapRootViewController *mapRootViewController;
	CalendarRootViewController *calendarRootViewController;
	DirectoryRootViewController *directoryRootViewController;
	AthleticsRootViewController *athleticsRootViewController;
	MediaRootViewController *mediaRootViewController;
	CourseRootViewController *courseRootViewController;
	WebBrowserRootViewController *emailRootViewController;
	WebBrowserRootViewController *myUCDavisRootViewController;
	WebBrowserRootViewController *smartSiteRootViewController;
	TransitRootViewController *transitRootViewController;
	CampusResourcesRootViewController *campusResourcesRootViewController;
}   

@property(nonatomic, retain) DepartmentRootViewController *departmentRootViewController;
@property(nonatomic, retain) NewspaperRootViewController *newspaperRootViewController;
@property(nonatomic, retain) MapRootViewController *mapRootViewController;
@property(nonatomic, retain) CalendarRootViewController *calendarRootViewController;
@property(nonatomic, retain) DirectoryRootViewController *directoryRootViewController;
@property(nonatomic, retain) AthleticsRootViewController *athleticsRootViewController;
@property(nonatomic, retain) MediaRootViewController *mediaRootViewController;
@property(nonatomic, retain) CourseRootViewController *courseRootViewController;
@property(nonatomic, retain) WebBrowserRootViewController *emailRootViewController;
@property(nonatomic, retain) TransitRootViewController *transitRootViewController;
@property(nonatomic, retain) CampusResourcesRootViewController *campusResourcesRootViewController;

- (IBAction)selectDepartments:(id)sender;
- (IBAction)selectNews:(id)sender;
- (IBAction)selectInformation:(id)sender;
- (IBAction)selectMap:(id)sender;
- (IBAction)selectCalendar:(id)sender;
- (IBAction)selectDirectory:(id)sender;
- (IBAction)selectEmail:(id)sender;
- (IBAction)selectAthletics:(id)sender;
- (IBAction)selectMedia:(id)sender;
- (IBAction)selectCourses:(id)sender;
- (IBAction)selectUnitrans:(id)sender;
- (IBAction)selectResources:(id)sender;

@end
