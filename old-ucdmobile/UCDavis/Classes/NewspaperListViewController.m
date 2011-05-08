//
//  NewsListViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewspaperListViewController.h"
//#import "LoadingViewController.h"
#import "MBProgressHud.h"
#import "WebServiceAdapter.h"
#import "ArticleWebViewController.h"
#import "ListViewCell.h"

#define kCellHeight @"94"

@interface NewspaperListViewController ()

- (void)synchronousLoadStories;
- (void)didFinishLoadingStories;

@end

@implementation NewspaperListViewController

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
	
	progressHud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:progressHud];
	progressHud.labelText = [NSString stringWithFormat:@"Loading news feeds..."];
	[progressHud show:YES];
}

- (void)synchronousLoadStories {
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

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.stories count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return [kCellHeight integerValue];	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *itemDictionary = [self.stories objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"ListViewCell";
	
	ListViewCell *cell = (ListViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ListViewCell" owner:nil options:nil];
		
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (ListViewCell *) currentObject;
				break;
			}
		}
	}
	
	cell.titleLabel.text = [itemDictionary objectForKey:@"title"];
	cell.dateLabel.text = [itemDictionary objectForKey:@"pubDate"];
	cell.descriptionLabel.text = [itemDictionary objectForKey:@"description"];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon.png", cell.titleLabel.text]];
	
	NSLog(@"Table stuff: ");
	NSLog(@"%@", [itemDictionary objectForKey:@"title"]);
	NSLog(@"%@", cell.descriptionLabel.text);
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*NewspaperDetailViewController *newspaperDetailViewController = [[NewspaperDetailViewController alloc] initWithNibName:@"NewspaperDetailViewController" bundle:nil];
	newspaperDetailViewController.rssItem = [self.stories objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:newspaperDetailViewController animated:YES];*/
	
	NSDictionary *itemDictionary = [self.stories objectAtIndex:indexPath.row];
	NSString *link = [itemDictionary objectForKey:@"link"];
	NSURL *url = [NSURL URLWithString:link];
	ArticleWebViewController *articleWebViewController = [[ArticleWebViewController alloc] initWithNibName:@"ArticleWebViewController" bundle:nil];
	
	articleWebViewController.website = url;
	
	[self.navigationController pushViewController:articleWebViewController animated:YES];
	
	//[newspaperDetailViewController release];
}

- (void)dealloc {
    [super dealloc];
}


@end

