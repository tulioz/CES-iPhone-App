//
//  MediaListViewController.m
//  UCDavis
//
//  Created by Fei Li on 11/22/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "MediaListViewController.h"
#import "MediaWebViewController.h"
//#import "LoadingViewController.h"
#import "MBProgressHud.h"
#import "WebServiceAdapter.h"
#import "ListViewCell.h"

#define kCellHeight 80.0

@interface MediaListViewController ()

- (void)synchronousLoadStories;
- (void)didFinishLoadingStories;

@end

@implementation MediaListViewController

@synthesize feedURL;
@synthesize feedName;
@synthesize stories;
@synthesize titleLabel;
@synthesize dateLabel;
@synthesize descriptionLabel;

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
	
	self.title = feedName;
	
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadStories) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	
	//loadingViewController = [[LoadingViewController alloc] initWithNibName:@"LoadingViewController" bundle:nil];
	//[self.view addSubview:loadingViewController.view];
	progressHud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:progressHud];
	progressHud.labelText = [NSString stringWithFormat:@"Loading media feed..."];
	[progressHud show:YES];
}

- (void)synchronousLoadStories {
	if (self.stories == nil) 
		self.stories = [WebServiceAdapter fetchFeedByUrl:feedURL];

	[self performSelectorOnMainThread:@selector(didFinishLoadingStories) withObject:nil waitUntilDone:NO];
	
}

- (void)didFinishLoadingStories {
	[self.tableView reloadData];
	[progressHud removeFromSuperview];
	[progressHud release];
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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.stories count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	
	return kCellHeight;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *itemDictionary = [self.stories objectAtIndex:indexPath.row];
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 2;
    }
    
    // Set up the cell...
	cell.textLabel.text = [itemDictionary objectForKey:@"title"];
	cell.detailTextLabel.text = [itemDictionary objectForKey:@"pubDate"];
	//Grabs the video's thumbnail image from the description and converts it into a UIImage to display within the table cell.
	//Uncomment to enable.
	/*
	NSString *description = [itemDictionary objectForKey:@"description"];
	NSArray *tempDescBuffer = [description componentsSeparatedByString:@"img alt=\"\" src=\""];
	tempDescBuffer = [[tempDescBuffer objectAtIndex:1] componentsSeparatedByString:@"\""];
	NSString *imageString = [tempDescBuffer objectAtIndex:0];
	NSURL *imageURL = [NSURL URLWithString:imageString];
	NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
	UIImage *image = [UIImage imageWithData:imageData];
	
	cell.imageView.image = image;
	*/
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSDictionary *itemDictionary = [self.stories objectAtIndex:indexPath.row];
	NSString *link = [itemDictionary objectForKey:@"link"];
	NSURL *url = [NSURL URLWithString:link];
	//NSLog(@"NSURL String: ");
	//NSLog([url absoluteString]);
	
	MediaWebViewController *mediaWebViewController = [[MediaWebViewController alloc] 
														  initWithNibName:@"MediaWebViewController" bundle:nil];
	
	mediaWebViewController.website = url;
	
	[self.navigationController pushViewController:mediaWebViewController animated:YES];
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

