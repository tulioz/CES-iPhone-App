//
//  ArticleWebViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/23/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "ArticleWebViewController.h"
#import "MBProgressHud.h"


@implementation ArticleWebViewController

@synthesize webView;
@synthesize website;

- (void)dealloc {
	[webView release];
	[website release];
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
	NSLog(@"Loading %@", self.website);
	//self.title = @"Article";
	//self.title = [website absoluteString];
	
	[self.webView setDelegate:self];
	[self.webView loadRequest:[NSURLRequest requestWithURL:self.website]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"webViewDidStartLoad");
	/*activityIndicator.hidden = NO;
	 [activityIndicator startAnimating];*/
	
	progressHud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:progressHud];
	progressHud.labelText = [NSString stringWithFormat:@"Loading..."];
	[progressHud show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"webViewDidStopLoad");
	/*activityIndicator.hidden = YES;
	 [activityIndicator stopAnimating];*/
	
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

@end
