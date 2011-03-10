//
//  UCDavisAppDelegate.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/12/09.
//  Copyright gunrockstudios.com 2009. All rights reserved.
//

#import "UCDavisAppDelegate.h"
#import "RootViewController.h"
#import "GANTracker.h"

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;

@implementation UCDavisAppDelegate

@synthesize window;
@synthesize rootViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-12267626-3"
										   dispatchPeriod:kGANDispatchPeriodSec
												 delegate:nil];
	NSError *error;
	if (![[GANTracker sharedTracker] trackEvent:@"device"
										 action:@"isIPhone"
										  label:@"isIPhone"
										  value:[[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 1 : 0
									  withError:&error]) {
		// Handle error here
	}
	
	if (![[GANTracker sharedTracker] trackPageview:@"/home"
										 withError:&error]) {
		// Handle error here
	}
	
    // Override point for customization after application launch
	[window addSubview:rootViewController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
	[rootViewController release];
    [window release];
    [super dealloc];
}


@end
