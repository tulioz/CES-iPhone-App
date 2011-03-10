//
//  WebBrowserRootViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "WebBrowserRootViewController.h"
#import "CMWebBrowserViewController.h"

@implementation WebBrowserRootViewController

@synthesize navigationController;
@synthesize websiteURL;

- (void)selectHome:(id)sender {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	CMWebBrowserViewController *webBrowserViewController = (CMWebBrowserViewController *) navigationController.topViewController;
	// pass the website URL
	webBrowserViewController.websiteURL = self.websiteURL;
	// set the title
	webBrowserViewController.title = self.title;
	[self.view addSubview:self.navigationController.view];
	[self.navigationController.view setFrame:self.view.frame];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return YES;
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

- (void)dealloc {
	[navigationController release];
	[websiteURL release];
    [super dealloc];
}

@end