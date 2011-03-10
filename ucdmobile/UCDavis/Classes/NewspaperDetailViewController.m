//
//  NewspaperDetailViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/23/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "NewspaperDetailViewController.h"
#import "ArticleWebViewController.h"

@implementation NewspaperDetailViewController

@synthesize rssItem;
@synthesize titleLabel;
@synthesize pubDateLabel;
@synthesize descriptionTextView;
@synthesize spacerTopLeft;
@synthesize spacerTopRight;
@synthesize spacerBottomLeft;
@synthesize spacerBottomRight;


- (void)dealloc {
	[rssItem release];
    [super dealloc];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Article Summary";
	
	self.titleLabel.text = [self.rssItem objectForKey:@"title"];
	self.pubDateLabel.text = [self.rssItem objectForKey:@"pubDate"];
	self.descriptionTextView.text = [self.rssItem objectForKey:@"description"];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientation
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

- (IBAction)openRssLink:(id)sender {
	NSString *link = [self.rssItem objectForKey:@"link"];
	NSURL *url = [NSURL URLWithString:link];
	ArticleWebViewController *articleWebViewController = [[ArticleWebViewController alloc] initWithNibName:@"ArticleWebViewController" bundle:nil];
	articleWebViewController.website = url;
	[self.navigationController pushViewController:articleWebViewController animated:YES];
	[articleWebViewController release];	
}


@end
