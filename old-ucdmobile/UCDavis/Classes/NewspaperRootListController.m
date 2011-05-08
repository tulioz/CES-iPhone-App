//
//  NewspaperRootListController.m
//  UCDavis
//
//  Created by Fei Li on 12/3/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "NewspaperRootListController.h"
#import "NewspaperListViewController.h"
#import "ArticleWebViewController.h"
#import "CMWebBrowserViewController.h"


#define kCaliforniaAggie @"The California Aggie"
#define kDateline @"Dateline"
#define kUCDFacebook @"UC Davis"
#define kUCDEngFacebook @"UC Davis Engineering"

/*
#define fCaliforniaAggie @"http://theaggie.org/rss/headlines"
#define fDateline @"http://www.news.ucdavis.edu/xml/getnews.php?type=category&categories=Dateline&format=rss"*/

@implementation NewspaperRootListController
@synthesize rows;
@synthesize feedDictionary;

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
	
	self.rows = [[NSArray alloc] initWithObjects:kCaliforniaAggie, kDateline, kUCDFacebook, kUCDEngFacebook, nil];
	
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
	NSString *macReader = @"http://reader.mac.com/mobile/v1/";
	NSString *urlString = [macReader stringByAppendingString:[feedDictionary objectForKey:feed]];
	
	CMWebBrowserViewController *webBrowserViewController = [[CMWebBrowserViewController alloc] initWithNibName:@"CMWebBrowserViewController" bundle:nil];
	
	webBrowserViewController.websiteURL = [NSURL URLWithString:urlString];
	webBrowserViewController.title = feed;
	
	[self.navigationController pushViewController:webBrowserViewController animated:YES];
	[webBrowserViewController release];
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
