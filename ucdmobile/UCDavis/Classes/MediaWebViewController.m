//
//  MediaWebViewController.m
//  UCDavis
//
//  Created by Fei Li on 11/22/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "MediaWebViewController.h"


@implementation MediaWebViewController

@synthesize webView;
@synthesize website;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *URLString = [website absoluteString];
	URLString = [URLString substringFromIndex:31];
	NSLog(URLString);
	NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"420\"><param name=\"movie\" value=\"http://www.youtube.com/v/%@&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"http://www.youtube.com/v/%@&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"420\"></embed></object></div></body></html>", URLString, URLString];
	//NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"420\"><param name=\"movie\" value=\"http://www.youtube.com/v/oHg5SJYRHA0&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"http://www.youtube.com/v/oHg5SJYRHA0&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"420\"></embed></object></div></body></html>"];	
	//NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"420\"><param name=\"movie\" value=\"http://www.youtube.com/v/AFh5nazLiYI&feature=youtube_gdata&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"http://www.youtube.com/v/AFh5nazLiYI&feature=youtube_gdata&f=gdata_videos&c=ytapi-my-clientID&d=nGF83uyVrg8eD4rfEkk22mDOl3qUImVMV6ramM\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"420\"></embed></object></div></body></html>"];	
	
	NSLog(htmlString);
	
	self.title = @"Video";
	
	[webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.ucdavis.edu/"]];
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


- (void)dealloc {
	[webView release];
	[website release];
    [super dealloc];
}


@end
