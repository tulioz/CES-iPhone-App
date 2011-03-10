//
//  TicketPickerViewController.m
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TicketPickerViewController.h"


@implementation TicketPickerViewController

@synthesize currentLink;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	sourcesArray = [[NSMutableArray alloc] init];
//	PhotoTableLinkModel *aLink = [[PhotoTableLinkModel alloc] init];
	
//	aLink.linkTitle = @"Source 1";
//	aLink.linkImageName = @"antoine.png";
//	aLink.linkURLName = @"http://google.com";

	PhotoTableLinkModel *aLink = [[PhotoTableLinkModel alloc] initWithTitle:@"Mondavi Center Ticketing" image:@"header_mc_logo.gif" URL:@"http://google.com"];
	
	PhotoTableLinkModel *otherLink = [[PhotoTableLinkModel alloc] initWithTitle:@"Second Item" image:@"antoine.png" URL:@"http://yahoo.com"];
	
	[sourcesArray addObject: aLink];
	[sourcesArray addObject:otherLink];
	[aLink release];
	
//	[self init];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(id)init {
//	if(self = [super initWithStyle:UITableViewStyleGrouped]) {
	if (self = [super initWithNibName:@"TicketPickerViewController" bundle:nil]) {
		NSLog(@"Calling init...");
		self.title = @"Choose a Source...";

//		self.variableHeightRows = YES;
	}
	
	
	return self;
}

-(id)initWithCoder:(NSCoder *)coder {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
	}
	return self;
}

-(id)initWithStyle:(UITableViewStyle)style {
	NSLog(@"calling initWithStyle...");
	
	[super initWithStyle:style];
	return self;
}
	

//-(void)createModel {
//	return;
//	self.dataSource = [[[TicketPickerDataSource alloc] init] autorelease];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"calling cellForRowAtIndexPath!");
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	PhotoTableLinkModel *theLink = [sourcesArray objectAtIndex:indexPath.row];
//	UILabel *titleLabel = (UILabel *) [
	cell.textLabel.text = theLink.linkTitle;
//	cell.textLabel.text = @"Testing!";
	cell.imageView.image= theLink.linkImage;
	return cell;
	
	
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [sourcesArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	currentLink = [sourcesArray objectAtIndex:indexPath.row];
	
	[[TTNavigator navigator] openURLAction:
	 [currentLink.linkURL applyAnimated:YES]];
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
