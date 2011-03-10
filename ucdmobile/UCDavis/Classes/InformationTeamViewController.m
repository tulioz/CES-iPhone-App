//
//  InformationBodyViewController.m
//  UCDavis
//
//  Created by Fei Li on 10/18/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "InformationTeamViewController.h"
#import "UIColor+CustomColors.h"
#import "UIAlertHelper.h"
#import "CMWebBrowserViewController.h"

#define kFeedbackSection 1
#define kFeatureRequest 0
#define kBugReport 1

#define kFeedbackEmail @"ucdapp@gmail.com"
#define kFeatureRequestBody @"Hi UCD App,\n\nI want to see this in the next update:\n\n\nI think it will be useful because:\n\n"
#define kBugReportBody @"Hi UCD App,\n\nThis is what happened:\n\n\nThese are the steps you can take to recreate the bug:\n1.\n"

static NSString *kSectionKey = @"sectionKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kDetailKey = @"detailKey";
static NSString *kURLKey = @"URLKey";

@implementation InformationTeamViewController

@synthesize dataSourceArray;

- (void)dealloc {
	[dataSourceArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.dataSourceArray = [NSMutableArray array];
	
	// Project website
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"UCD Mobile", nil], kSourceKey, [NSArray arrayWithObjects:@"The Official Website", nil], kDetailKey, [NSArray arrayWithObjects:@"http://www.ucdmobile.com", nil], kURLKey, @"Official Links", kSectionKey, nil]];
	
	// Feedback
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"Feature Request", @"Bug Report", nil], kSourceKey, [NSArray arrayWithObjects:@"What would you like to see next?", @"Tell us about any crashes, bugs, etc.", nil], kDetailKey, @"Feedback", kSectionKey, nil]];
	
	// Lead Developers
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"Sunny Dhillon", @"Fei Li", nil], kSourceKey, [NSArray arrayWithObjects:@"Lead Developer", @"Lead Developer", nil], kDetailKey, [NSArray arrayWithObjects:@"http://sdhillon.com", @"http://www.linkedin.com/pub/fei-li/19/404/831", nil], kURLKey, @"Project Leaders", kSectionKey, nil]];
	
	// Developers
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"William Zhang", nil], kSourceKey, [NSArray arrayWithObjects:@"Developer", nil], kDetailKey, [NSArray arrayWithObjects:@"http://www.linkedin.com/pub/william-zhang/1a/50b/117", nil], kURLKey, @"Team Members", kSectionKey, nil]];
	
	// Support
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"Serban Porumbescu", @"Prof. Ken Joy", nil], kSourceKey, [NSArray arrayWithObjects:@"Guest Instructor for ECS 189h", @"Instructor for ECS 189h", nil], kDetailKey, [NSArray arrayWithObjects:@"http://graphics.cs.ucdavis.edu/~porumbes/", @"http://idav.ucdavis.edu/~joy/", nil], kURLKey, @"Supporting Cast", kSectionKey, nil]];
	
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
    NSString *detail = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kDetailKey] objectAtIndex:indexPath.row];
	NSString *source = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kSourceKey] objectAtIndex:indexPath.row];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = source;
	cell.detailTextLabel.text = detail;
	cell.accessoryType = UITableViewCellAccessoryNone;
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSString *source = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kSourceKey] objectAtIndex:indexPath.row];

	if(indexPath.section == kFeedbackSection) {
		if([MFMailComposeViewController canSendMail]) {
			// fill out email
			NSString *emailSubject = source;
			NSString *emailBodyTemplate = indexPath.row == kFeatureRequest ? kFeatureRequestBody : kBugReportBody;
			MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
			controller.mailComposeDelegate = self;
			[[controller navigationBar] setTintColor:[UIColor oceanColor]];
			[controller setToRecipients:[NSArray arrayWithObject:kFeedbackEmail]];
			[controller setSubject:emailSubject];
			[controller setMessageBody:emailBodyTemplate isHTML:NO];
			[self presentModalViewController:controller animated:YES];
		} else {
			[UIAlertHelper mailErrorAlert];
		}
	} else {
		NSString *url = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kURLKey] objectAtIndex:indexPath.row];
		CMWebBrowserViewController *webBrowserViewController = [[CMWebBrowserViewController alloc] initWithNibName:@"CMWebBrowserViewController" bundle:nil];
		webBrowserViewController.websiteURL = [NSURL URLWithString:[url stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
		webBrowserViewController.title = source;
		[self.navigationController pushViewController:webBrowserViewController animated:YES];
		[webBrowserViewController release];	
	}
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}

@end

