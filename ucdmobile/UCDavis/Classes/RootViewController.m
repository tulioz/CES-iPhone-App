//
//  RootViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "RootViewController.h"
#import "DepartmentRootViewController.h"
#import "InformationRootViewController.h"
#import "NewspaperRootViewController.h"
#import "MapRootViewController.h"
#import "CalendarRootViewController.h"
#import "DirectoryRootViewController.h"
#import "ArticleWebViewController.h"
#import "AthleticsRootViewController.h"
#import "MediaRootViewController.h"
#import "CourseRootViewController.h"
#import "TransitRootViewController.h"
#import "WebBrowserRootViewController.h"
#import "CampusResourcesRootViewController.h"
#import "GANTracker.h"

@implementation RootViewController

@synthesize departmentRootViewController;
@synthesize newspaperRootViewController;
@synthesize mapRootViewController;
@synthesize calendarRootViewController;
@synthesize directoryRootViewController;
@synthesize athleticsRootViewController;
@synthesize mediaRootViewController;
@synthesize courseRootViewController;
@synthesize emailRootViewController;
@synthesize transitRootViewController;
@synthesize campusResourcesRootViewController;

- (void)dealloc {
	[newspaperRootViewController release];
	[mapRootViewController release];
	[calendarRootViewController release];
	[directoryRootViewController release];
	[athleticsRootViewController release];
	[mediaRootViewController release];
	[courseRootViewController release];
	[emailRootViewController release];
	[transitRootViewController release];
	[campusResourcesRootViewController release];
    [super dealloc];
}

- (IBAction)selectDepartments:(id)sender {
	if(self.departmentRootViewController == nil) {
		DepartmentRootViewController *rootView = [[DepartmentRootViewController alloc] initWithNibName:@"DepartmentRootViewController" bundle:nil];
		self.departmentRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.departmentRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/departments"
										 withError:&error]) {
		// Handle error here
	}	
}

- (IBAction)selectNews:(id)sender {
	if(self.newspaperRootViewController == nil) {
		NewspaperRootViewController *rootView = [[NewspaperRootViewController alloc] initWithNibName:@"NewspaperRootViewController" bundle:nil];
		self.newspaperRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.newspaperRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/news"
										 withError:&error]) {
		// Handle error here
	}	
}

- (IBAction)selectInformation:(id)sender {
	InformationRootViewController *rootView = [[InformationRootViewController alloc] initWithNibName:@"InformationRootViewController" bundle:nil];
	[self presentModalViewController:rootView animated:YES];
	[rootView release];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/information"
										 withError:&error]) {
		// Handle error here
	}		
}

- (IBAction)selectMap:(id)sender {
	if(self.mapRootViewController == nil) {
		MapRootViewController *rootView = [[MapRootViewController alloc] initWithNibName:@"MapRootViewController" bundle:nil];
		self.mapRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.mapRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/map"
										 withError:&error]) {
		// Handle error here
	}		
}

- (IBAction)selectCalendar:(id)sender {
	if(self.calendarRootViewController == nil) {
		CalendarRootViewController *rootView = [[CalendarRootViewController alloc] initWithNibName:@"CalendarRootViewController" bundle:nil];
		self.calendarRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.calendarRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/calendar"
										 withError:&error]) {
		// Handle error here
	}	
}

- (IBAction)selectDirectory:(id)sender {
	if(self.directoryRootViewController == nil) {
		DirectoryRootViewController *rootView = [[DirectoryRootViewController alloc] initWithNibName:@"DirectoryRootViewController" bundle:nil];
		self.directoryRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.directoryRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/directory"
										 withError:&error]) {
		// Handle error here
	}	
}

- (IBAction)selectAthletics:(id)sender {
	if(self.athleticsRootViewController == nil) {
		AthleticsRootViewController *rootView = [[AthleticsRootViewController alloc] initWithNibName:@"AthleticsRootViewController" bundle:nil];
		self.athleticsRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.athleticsRootViewController animated:YES];

	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/athletics"
										 withError:&error]) {
		// Handle error here
	}		
}

- (IBAction)selectMedia:(id)sender {
	if(self.mediaRootViewController == nil) {
		MediaRootViewController *rootView = [[MediaRootViewController alloc] initWithNibName:@"MediaRootViewController" bundle:nil];
		self.mediaRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.mediaRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/media"
										 withError:&error]) {
		// Handle error here
	}		
}

- (IBAction)selectResources:(id)sender {
	if(self.campusResourcesRootViewController == nil) {
		CampusResourcesRootViewController *rootView = [[CampusResourcesRootViewController alloc] initWithNibName:@"CampusResourcesRootViewController" bundle:nil];
		self.campusResourcesRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.campusResourcesRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/resources"
										 withError:&error]) {
		// Handle error here
	}		
}

- (IBAction)selectEmail:(id)sender {
	if(self.emailRootViewController == nil) {
		WebBrowserRootViewController *rootView = [[WebBrowserRootViewController alloc] initWithNibName:@"WebBrowserRootViewController" bundle:nil];
		rootView.title = @"UC Davis Email";
		rootView.websiteURL = [NSURL URLWithString:@"http://mail.google.com/a/ucdavis.edu"];
		self.emailRootViewController = rootView;
		[rootView release];
	}
	
	[self presentModalViewController:self.emailRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/email"
										 withError:&error]) {
		// Handle error here
	}			
}

- (IBAction)selectCourses:(id)sender {
	if(self.courseRootViewController == nil) {
		CourseRootViewController *rootView = [[CourseRootViewController alloc] initWithNibName:@"CourseRootViewController" bundle:nil];
		self.courseRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.courseRootViewController animated:YES];

	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/courses"
										 withError:&error]) {
		// Handle error here
	}	
}

- (IBAction)selectUnitrans:(id)sender {
	if(self.transitRootViewController == nil) {
		TransitRootViewController *rootView = [[TransitRootViewController alloc] initWithNibName:@"TransitRootViewController" bundle:nil];
		self.transitRootViewController = rootView;
		[rootView release];
	}
	[self presentModalViewController:self.transitRootViewController animated:YES];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/unitrans"
										 withError:&error]) {
		// Handle error here
	}		
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view addSubview:searchBar];
}

#pragma mark -
#pragma mark Search Bar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)aSearchBar {
	[aSearchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
	WebBrowserRootViewController *rootView = [[WebBrowserRootViewController alloc] initWithNibName:@"WebBrowserRootViewController" bundle:nil];
	rootView.title = @"UC Davis Search";
	rootView.websiteURL = [NSURL URLWithString:[[NSString stringWithFormat:@"http://www.google.com/search?q=%@ site:ucdavis.edu&client=safari", aSearchBar.text] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	
	aSearchBar.showsCancelButton = NO;
	[aSearchBar resignFirstResponder];
	[self presentModalViewController:rootView animated:YES];
	[rootView release];
	
	// Track page view with Google Analytics
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/search"
										 withError:&error]) {
		// Handle error here
	}			
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
	[aSearchBar setShowsCancelButton:NO animated:YES];
	
	[aSearchBar resignFirstResponder];
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

@end
