//
//  CourseDetailViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/22/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "Course.h"
#import "CourseTime.h"
#import "CMDepartment.h"
#import "CMBuilding.h"
#import "DatabaseHelper.h"
#import "CMMapViewController.h"
#import "DirectoryListViewController.h"
#import "CMWebBrowserViewController.h"

#define kDescriptionSize 12
#define kDefaultCellHeight 44
#define kCellPadding 10

static NSString *kSectionKey = @"sectionKey";
static NSString *kLabelKey = @"labelKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kDetailKey = @"detailKey";

static int kDescriptionIndex = 0;
static Boolean hasDescription = NO;
static int kTextbookIndex = 0;
static Boolean hasTextbooks = NO;

@interface CourseDetailViewController ()

- (NSString*)amazonLinkFromISBN13:(NSString *)ISBN13;

@end

@implementation CourseDetailViewController

@synthesize department;
@synthesize courseDictionary;
@synthesize courses;
@synthesize dataSourceArray;
@synthesize headerView;
@synthesize headerCourseTitleLabel;

- (void)dealloc {
	[department release];
	[courseDictionary release];
	[courses release];
	[dataSourceArray release];
	[headerView release];
	[headerCourseTitleLabel release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [NSString stringWithFormat:@"%@ %@", self.department.abbreviation, [courseDictionary objectForKey:@"number"]];
	
	self.courses = [[DatabaseHelper sharedInstance] coursesByNumber:[courseDictionary objectForKey:@"number"] department:department];
	
	// set up header
	self.tableView.tableHeaderView = self.headerView;
	self.headerCourseTitleLabel.text = [courseDictionary objectForKey:@"title"];
	
	self.dataSourceArray = [NSMutableArray array];
	
	Course *anyCourse = [self.courses objectAtIndex:0];
	// course description
	NSDictionary *courseMetadataDictionary = [[DatabaseHelper sharedInstance] courseMetadataDictionaryByDepartment:department	course:anyCourse];
	if(courseMetadataDictionary != nil) {
		hasDescription = YES;
		[dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"description", nil], kLabelKey, [NSArray arrayWithObjects:[courseMetadataDictionary objectForKey:@"description"], nil], kSourceKey, @"Description", kSectionKey, nil]];
		self.headerCourseTitleLabel.text = [courseMetadataDictionary objectForKey:@"title"];
	} else {
		hasDescription = NO;
	}
	
	// textbooks
	NSArray *textbooks = [[DatabaseHelper sharedInstance] courseTextbookDictionariesByDepartment:self.department course:anyCourse];
	kTextbookIndex = hasDescription ? 1 : 0; // if there is a description we are the 2nd section
	if([textbooks count] > 0) {
		hasTextbooks = YES;
		NSMutableArray *textbookLabels = [NSMutableArray array];
		NSMutableArray *textbookSources = [NSMutableArray array];
		NSMutableArray *textbookDetails = [NSMutableArray array];
		for(NSDictionary *textbook in textbooks) {
			[textbookLabels addObject:@"textbook"];
			[textbookSources addObject:[textbook objectForKey:@"title"]];
			[textbookDetails addObject:[textbook objectForKey:@"isbn"]];
		}
		[dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:textbookLabels, kLabelKey, textbookSources, kSourceKey, textbookDetails, kDetailKey, @"Textbooks", kSectionKey, nil]];
	} else {
		hasTextbooks = NO;
	}
	
	// general course information
	[dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"number", @"units", nil], kLabelKey, [NSArray arrayWithObjects:[courseDictionary objectForKey:@"number"], anyCourse.units, nil], kSourceKey, @"Details", kSectionKey, nil]];
	
	// detail course information
	for(Course *aCourse in self.courses) {
		NSMutableArray *labelArray = [NSMutableArray arrayWithObjects:@"crn", @"type", nil];
		NSMutableArray *sourceArray = [NSMutableArray arrayWithObjects:aCourse.crn, aCourse.type, nil];
		if(![aCourse.section isEqual:@""]) {
			[labelArray addObject:@"section"];
			[sourceArray addObject:aCourse.section];
		}
		[labelArray addObject:@"instructor"];
		[sourceArray addObject:aCourse.instructor];
		if(![aCourse.seats isEqual:@""]) {
			[labelArray addObject:@"seats"];
			[sourceArray addObject:aCourse.seats];
		}
		// add any course time if available
		for(CourseTime *courseTime in aCourse.courseTimes) {
			[labelArray addObject:@"days"];
			[sourceArray addObject:courseTime.days];
			[labelArray addObject:@"time"];
			[sourceArray addObject:courseTime.time];
			if(![courseTime.buildingName isEqual:@""]) {
				[labelArray addObject:@"room"];
				[sourceArray addObject:[NSString stringWithFormat:@"%@ %@", courseTime.buildingName, courseTime.room]];
			}
		}
		[dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:labelArray, kLabelKey, sourceArray, kSourceKey, nil]];
	}
	
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[self.dataSourceArray objectAtIndex:section] objectForKey:kSectionKey];
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
	// description cell is Default Cell Style
	if(hasDescription && indexPath.section == kDescriptionIndex) {
		static NSString *CellIdentifier = @"DescriptionCell";
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.textLabel.font = [UIFont systemFontOfSize:kDescriptionSize];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.text = source;
	} else if(hasTextbooks && indexPath.section == kTextbookIndex) {
		static NSString *CellIdentifier = @"TextbookCell";
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.textLabel.font = [UIFont systemFontOfSize:kDescriptionSize];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.text = source;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else {
		static NSString *CellIdentifier = @"Cell";
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		}
		cell.textLabel.text = label;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.detailTextLabel.text = source;
		
		// add detail button to drillable cells
		NSArray *disclosureLabelArray = [NSArray arrayWithObjects:@"room", @"instructor", nil];
		if([disclosureLabelArray containsObject:label]) {
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// calculate room for the description or textbook
	if((hasDescription && indexPath.section == kDescriptionIndex) || (hasTextbooks && indexPath.section == kTextbookIndex)) {
		NSString *source = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kSourceKey] objectAtIndex:indexPath.row];
		CGSize expectedLabelSize = [source sizeWithFont:[UIFont systemFontOfSize:kDescriptionSize] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 9999) lineBreakMode:UILineBreakModeWordWrap];
		return MAX(expectedLabelSize.height + 2*kCellPadding, kDefaultCellHeight);
	}
	return kDefaultCellHeight;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	 [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
	 NSString *label = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kLabelKey] objectAtIndex:indexPath.row];
	 NSString *source = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kSourceKey] objectAtIndex:indexPath.row];
	 NSInteger index = indexPath.section - 1 - (hasDescription == YES ? 1 : 0); // section - number/units - description
	 
	 if([label isEqualToString:@"room"]) {
		 Course *course = [self.courses objectAtIndex:index];
		 for(CourseTime *courseTime in course.courseTimes) {
			 NSString *room = [NSString stringWithFormat:@"%@ %@", courseTime.buildingName, courseTime.room];
			 // room matches and we have a building to send to map view controller
			 if([room isEqual:source]) {
				 CMMapViewController *mapViewController = [[CMMapViewController alloc] initWithNibName:@"CMMapViewController" bundle:nil];
				 [self.navigationController pushViewController:mapViewController animated:YES];
				 [mapViewController performSelectorOnMainThread:@selector(addBuildingToMap:) withObject:courseTime.building waitUntilDone:NO];
				 break;
			 }
		 }
	 } else if([label isEqualToString:@"instructor"]) {
		 NSArray *nameComponents = [source componentsSeparatedByString:@", "];
		 DirectoryListViewController *directoryListViewController = [[DirectoryListViewController alloc] initWithNibName:@"DirectoryListViewController" bundle:nil];
		 [self.navigationController pushViewController:directoryListViewController animated:YES];
		 if([nameComponents count] > 1) { // found last name and first initial
			 NSString *lastName = [nameComponents objectAtIndex:0];
			 NSString *firstInitial = [[nameComponents objectAtIndex:1] substringToIndex:1];
			 NSString *name = [NSString stringWithFormat:@"%@ %@", firstInitial, lastName];
			 [directoryListViewController performSelectorOnMainThread:@selector(searchForPersonWithName:) withObject:name waitUntilDone:NO];
		 } else { // parse error, 
			 [directoryListViewController performSelectorOnMainThread:@selector(searchForPersonWithName:) withObject:source waitUntilDone:NO];
		 }		 
	 } else if([label isEqualToString:@"textbook"]) {
		 NSString *isbn13 = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kDetailKey] objectAtIndex:indexPath.row];
		 CMWebBrowserViewController *webBrowserViewController = [[CMWebBrowserViewController alloc] initWithNibName:@"CMWebBrowserViewController" bundle:nil];
		 webBrowserViewController.websiteURL = [NSURL URLWithString:[[self amazonLinkFromISBN13:isbn13] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
		 webBrowserViewController.title = source;
		 [self.navigationController pushViewController:webBrowserViewController animated:YES];
		 [webBrowserViewController release];	
	 }
 }

#pragma mark -
#pragma mark Private Methods

- (NSString*)amazonLinkFromISBN13:(NSString *)ISBN13 {
	
	// convert ISBN13 to ISBN10
	NSString *ISBN10 = [ISBN13 substringWithRange:NSMakeRange(3, 9)];
	
	int weight = 10;
	int checksum = 0;
	int charIndex;
	for (charIndex = 0; charIndex < [ISBN10 length]; charIndex++) {
		checksum += (digittoint([ISBN10 characterAtIndex:charIndex])*weight);
		weight--;
	}
	checksum = 11 - (checksum % 11);
	
	if (checksum == 10) {
		ISBN10 = [ISBN10 stringByAppendingString:@"X"];
	} else if (checksum == 11) {
		ISBN10 = [ISBN10 stringByAppendingString:@"0"];
	} else {
		NSString *str_checksum = [NSString stringWithFormat:@"%d", checksum];
		ISBN10 = [ISBN10 stringByAppendingString:str_checksum];
	}
	
	NSString *mobile_url = @"http://www.amazon.com/gp/aw/d.html/ref=is_a_";
	mobile_url = [mobile_url stringByAppendingString:ISBN10];
	mobile_url = [mobile_url stringByAppendingString:@"?a="];
	mobile_url = [mobile_url stringByAppendingString:ISBN10];
	
	return mobile_url;
	
}


@end

