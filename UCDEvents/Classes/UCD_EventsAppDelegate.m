//
//  UCD_EventsAppDelegate.m
//  UCD Events
//
//  Created by William Binns-Smith on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UCD_EventsAppDelegate.h"
#import "UCD_EventsViewController.h"
#import "BasicLauncherViewController.h"
#import "RSSFeedTableViewController.h"
#import "TicketPickerViewController.h"
#import "TicketChooserViewController.h"
#import "LocationListViewController.h"
#import "LocationDetailViewController.h"
#import "EventListViewController.h"

@implementation UCD_EventsAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
	
	[TTURLCache sharedCache].disableDiskCache = YES;
	[[TTURLCache sharedCache] removeAll:YES];
	
	
	//	NSLog(@"hmm0....");
	TTNavigator* navigator = [TTNavigator navigator];
	//navigator.window = window;
	navigator.persistenceMode = TTNavigatorPersistenceModeAll;
	TTURLMap* map = navigator.URLMap;
	
	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"ucde://launcher/" toViewController:
	 [BasicLauncherViewController class]];
	[map from:@"ucde://newsfeed/" toViewController:
	 [RSSFeedTableViewController class]];
	[map from:@"ucde://ticketpicker/" toViewController:
	 [TicketPickerViewController class]];
	[map from:@"ucde://ticketpicker/(initWithStyle:)" toViewController:
	 [TicketPickerViewController class]];
	[map from:@"ucde://ticketchooser/(initWithStyle:)" toViewController:
	 [TicketChooserViewController class]];
	[map from:@"ucde://locationList/(initWithName:)/(url:)/" toViewController:
	 [LocationListViewController class]];
	[map from:@"ucde://locationDetail/" toViewController:[LocationDetailViewController class]]; 
	[map from:@"ucde://locationDetail/location/(initWithID:)/(query:)" toViewController:[LocationDetailViewController class]];
	
	[map from:@"ucde://eventList/(initWithName:)/(url:)/" toViewController:
	 [EventListViewController class]];
	
	//	NSLog(@"hmmm1....");
	
	if (![navigator restoreViewControllers]) {
		[[TTNavigator navigator] openURLAction:
		 [[TTURLAction actionWithURLPath:@"ucde://launcher"] applyAnimated:YES]];
		//		NSLog(@"hmmm...");
		//[navigator openURLAction:
		// [[TTURLAction actionWithURLPath:@"tt://launcher"]
		//  applyAnimated:YES]];
	}
	
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
	[self saveContext];
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}



- (void)saveContext {
    
}    

#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
