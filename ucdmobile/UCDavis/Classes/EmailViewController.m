//
//  EmailViewController.m
//  UCDavis
//
//  Created by Fei Li on 12/4/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "EmailViewController.h"
#import "MBProgressHud.h"

#define kEmailURL @"http://mail.google.com/a/ucdavis.edu"

@implementation EmailViewController
@synthesize webView;
//@synthesize activityIndicator;
@synthesize urlString;
@synthesize titleString;
@synthesize website;

- (void)dealloc {
	[webView release];
	//[activityIndicator release];
	[urlString release];
	[website release];
    [super dealloc];
}

- (void)selectHome:(id)sender {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
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
	self.navigationItem.title = titleString;
	//self.title = @"Article";
	//self.title = [website absoluteString];
	website = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSLog(@"URL string: %@", urlString);
	NSLog(@"URL: %@", website);
	//activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	[self.webView setDelegate:self];
	NSLog(@"Delegate set");
	[self.webView loadRequest:[NSURLRequest requestWithURL:self.website]];
	NSLog(@"FFFFUUUU");
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
