//
//  MediaRootListController.m
//  UCDavis
//
//  Created by Fei Li on 11/22/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "MediaRootListController.h"
#import "MediaListViewController.h"
#import "MediaRadioViewController.h"

#define kRadioRow 0
#define kAggieTVRow 1
#define kUCDYouTubeRow 2

#define kRadio @"KDVS Radio"
#define kAggieTV @"AggieTV"
#define kUCDYouTube @"UC Davis Channel"

//#define fAggieTV @"http://gdata.youtube.com/feeds/base/users/asucd/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile"
//#define fUCDYouTube @"http://gdata.youtube.com/feeds/base/users/UCDavis/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile"


@implementation MediaRootListController

@synthesize rows;
@synthesize feedDictionary;
@synthesize kdvsViewController;
@synthesize aggieTvViewController;
@synthesize davisYoutubeViewController;

- (void)dealloc {
	[rows release];
	[feedDictionary release];
	[kdvsViewController release];
	[aggieTvViewController release];
	[davisYoutubeViewController release];
    [super dealloc];
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.rows = [[NSArray alloc] initWithObjects:kRadio, kAggieTV, kUCDYouTube, nil];
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:@"RSSFeeds" ofType:@"plist"];
	NSDictionary *RSSFeeds = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
	self.feedDictionary = RSSFeeds;
	[RSSFeeds release];
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

- (void)viewDidDisappear:(BOOL)animated {
	NSLog(@"Disappear");
	[super viewDidDisappear:animated];
}

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
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rows count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = [self.rows objectAtIndex:indexPath.row];
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon.png", cell.textLabel.text]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSString *feed = [self.rows objectAtIndex:indexPath.row];
	
	//KDVS stuff here
	if(indexPath.row == kRadioRow) {
		NSLog(@"Selected KDVS");
		MediaRadioViewController *mediaRadioViewController = [[MediaRadioViewController alloc] 
														  initWithNibName:@"MediaRadioViewController" bundle:nil];
		
		mediaRadioViewController.website = [NSURL URLWithString:@"http://169.237.101.62:8000/kdvs128"];
		
		self.kdvsViewController = mediaRadioViewController;
		[mediaRadioViewController release];
		
		[self.navigationController pushViewController:kdvsViewController animated:YES];		
	} else if(indexPath.row == kAggieTVRow) {
		NSLog(@"Selected AggieTV");
		if(self.aggieTvViewController == nil) {
			MediaListViewController *mediaListViewController = [[MediaListViewController alloc] 
									   initWithNibName:@"MediaListViewController" bundle:nil];
			mediaListViewController.feedName = feed;
			mediaListViewController.feedURL = [NSURL URLWithString:[feedDictionary objectForKey:feed]];
			
			self.aggieTvViewController = mediaListViewController;
			[mediaListViewController release];
		}
		[self.navigationController pushViewController:aggieTvViewController animated:YES];
	} else if(indexPath.row == kUCDYouTubeRow) {
		NSLog(@"Selected UCDYoutube");
		if(self.davisYoutubeViewController == nil) {
			MediaListViewController *mediaListViewController = [[MediaListViewController alloc] 
																initWithNibName:@"MediaListViewController" bundle:nil];
			mediaListViewController.feedName = feed;
			mediaListViewController.feedURL = [NSURL URLWithString:[feedDictionary objectForKey:feed]];
			
			self.davisYoutubeViewController = mediaListViewController;
			[mediaListViewController release];
		}
		[self.navigationController pushViewController:davisYoutubeViewController animated:YES];
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

@end

