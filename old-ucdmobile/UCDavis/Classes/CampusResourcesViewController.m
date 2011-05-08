//
//  CampusResourcesViewController.m
//  UCDavis
//
//  Created by Fei Li on 2/15/10.
//  Copyright 2010 gunrockstudios.com. All rights reserved.
//

#import "CampusResourcesViewController.h"

//Can't use these to populate the array for some reason.
#define kPolice @"Campus Police";
#define kFire @"Campus Fire";
#define kEscort @"Campus Escort";
#define kVehicle @"TAPS Vehicle Services";
#define kTipsyTaxi @"Tipsy Taxi";

#define nPolice @"530-752-1727";
#define nFire @"530-752-1236";
#define nEscort @"530-752-1727";
#define nVehicle @"530-752-8277";
#define nTipsyTaxi @"530-752-6666";

static NSString *kSectionKey = @"sectionKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kDetailKey = @"detailKey";

@implementation CampusResourcesViewController

@synthesize dataSourceArray;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (BOOL)isPhone {
	return [[UIDevice currentDevice].model isEqualToString:@"iPhone"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	/*NSLog([UIDevice currentDevice].model);
	if ([self isPhone]) {
		NSLog(@"Yep it's a phone");
	} else {
		NSLog(@"Nope it's not a phone");
	}*/

	
	self.dataSourceArray = [NSMutableArray array];
	// Campus contacts
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"Campus Operator", nil], kSourceKey, [NSArray arrayWithObjects:@"530-752-1011", nil], kDetailKey, @"Campus Contacts", kSectionKey, nil]];
	// Emergency contacts
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"Campus Police", @"Campus Fire", @"Campus Escort", nil], kSourceKey, [NSArray arrayWithObjects:@"530-752-1727", @"530-752-1236", @"530-752-1727", nil], kDetailKey, @"Emergency Contacts", kSectionKey, nil]];
	// Transportation & Vehicle Services
	[self.dataSourceArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"TAPS Vehicle Services", @"Tipsy Taxi", nil], kSourceKey, [NSArray arrayWithObjects:@"530-752-8277", @"530-752-6666", nil], kDetailKey, @"Transportation & Vehicle Services", kSectionKey, nil]];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[dataSourceArray release];
	[super dealloc];
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
	if ([self isPhone]) {
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	} else {		
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
		 
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSString *source = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kSourceKey] objectAtIndex:indexPath.row];
    NSString *number = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kDetailKey] objectAtIndex:indexPath.row];
	
	//If the user is on a phone, then make the call, otherwise copy the number to the clipboard. Or is that even necessary??
	if ([self isPhone]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", number]]];
	} else {
		UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
		[clipboard setValue:number forPasteboardType:@"public.utf8-plain-text"];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:source 
												  message:[NSString stringWithFormat:@"Phone number copied to clipboard:\n %@", number] 
												  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	}

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


- (void)dealloc {
    [super dealloc];
}


@end

