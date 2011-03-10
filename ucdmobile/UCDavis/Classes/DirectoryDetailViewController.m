//
//  DirectoryDetailViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/16/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "DirectoryDetailViewController.h"
#import "MBProgressHud.h"
#import "LabelViewCell.h"
#import "CMPerson.h"
#import "CMStudent.h"
#import "CMStaff.h"
#import "CMWebBrowserViewController.h"
#import "UIColor+CustomColors.h"
#import "UIAlertHelper.h"

static NSString *kLabelKey = @"labelKey";
static NSString *kSourceKey = @"sourceKey";

@implementation DirectoryDetailViewController

@synthesize person;
@synthesize dataSourceArray;
@synthesize headerView;
@synthesize headerPersonLabel;

- (void)dealloc {
	[person release];
	[dataSourceArray release];
	[headerView release];
	[headerPersonLabel release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Info";
	
	self.dataSourceArray = [NSMutableArray array];
	// set up rows
	self.dataSourceArray = [NSMutableArray array];
	// person details
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"name", @"email", nil], kLabelKey, [NSArray arrayWithObjects:person.name, person.email, nil], kSourceKey, nil]];
	
	// specific details
	if([person isKindOfClass:[CMStudent class]]) {
		CMStudent *student = (CMStudent *)person;
		[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"major", @"year", nil], kLabelKey, [NSArray arrayWithObjects:student.major, student.studentLevel, nil], kSourceKey, nil]];
	} else if([person isKindOfClass:[CMStaff class]]) {
		CMStaff *staff = (CMStaff *)person;
		NSMutableArray *labelArray = [NSMutableArray array];
		NSMutableArray *sourceArray = [NSMutableArray array];
		// might not have some information
		[labelArray addObject:@"title"];
		[sourceArray addObject:staff.title];
		[labelArray addObject:@"department"];
		[sourceArray addObject:staff.department];
		if(![staff.address isEqualToString:@""]) {
			[labelArray addObject:@"address"];
			[sourceArray addObject:staff.address];			
		}
		if(![staff.phone isEqualToString:@""]) {
			[labelArray addObject:@"phone"];
			[sourceArray addObject:staff.phone];			
		}
		if(![staff.website isEqualToString:@""]) {
			[labelArray addObject:@"website"];
			[sourceArray addObject:staff.website];			
		}
		[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:labelArray, kLabelKey, sourceArray, kSourceKey, nil]];
	}

	// set up the header
	self.headerPersonLabel.text = person.name;
	self.tableView.tableHeaderView = self.headerView;

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
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.textLabel.text = label;
	cell.detailTextLabel.text = source;
	
	// custom initialization
	NSArray *detailLabelArray = [NSArray arrayWithObjects:@"email", @"website", nil];
	if([detailLabelArray containsObject:label]) {
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSString *label = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kLabelKey] objectAtIndex:indexPath.row];
	NSString *source = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kSourceKey] objectAtIndex:indexPath.row];
	
	if([label isEqualToString:@"email"]) {
		if([MFMailComposeViewController canSendMail]) {
			MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
			controller.mailComposeDelegate = self;
			[[controller navigationBar] setTintColor:[UIColor oceanColor]];
			[controller setToRecipients:[NSArray arrayWithObject:person.email]];
			[controller setMessageBody:[NSString stringWithFormat:@"Hi %@,", person.firstName] isHTML:NO];
			[self presentModalViewController:controller animated:YES];
		} else {
			[UIAlertHelper mailErrorAlert];
		}
	} else if([label isEqualToString:@"website"]) {
		CMWebBrowserViewController *webBrowserViewController = [[CMWebBrowserViewController alloc] initWithNibName:@"CMWebBrowserViewController" bundle:nil];
		webBrowserViewController.websiteURL = [NSURL URLWithString:[source stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
		webBrowserViewController.title = self.person.name;
		[self.navigationController pushViewController:webBrowserViewController animated:YES];
		[webBrowserViewController release];		
	}
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end

