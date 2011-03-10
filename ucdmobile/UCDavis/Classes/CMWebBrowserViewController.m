//
//  CMWebBrowser.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "CMWebBrowserViewController.h"
#import "UIAlertHelper.h"

@implementation CMWebBrowserViewController

@synthesize websiteURL;
@synthesize webView;
@synthesize activityIndicatorView;
@synthesize backButton;
@synthesize forwardButton;

- (void)dealloc {
	// remove the network activity monitor if they went back
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;	
	
	[websiteURL release];
	[webView release];
	[activityIndicatorView release];
	[backButton release];
	[forwardButton release];
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
	
	// load the passed in website
	[self.webView loadRequest:[NSURLRequest requestWithURL:self.websiteURL]];
	
	// set up right button to give them a list of stops
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];	
	activityIndicator.hidesWhenStopped = YES;
	self.activityIndicatorView = activityIndicator;
    [activityIndicatorView release];
	
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicatorView];
    self.navigationItem.rightBarButtonItem = activityItem;
    [activityItem release];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


#pragma mark -
#pragma mark Web View Delegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[self.activityIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)theWebView {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	backButton.enabled = theWebView.canGoBack;
	forwardButton.enabled = theWebView.canGoForward;
	[self.activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[UIAlertHelper networkErrorAlert];
	[self.activityIndicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

@end
