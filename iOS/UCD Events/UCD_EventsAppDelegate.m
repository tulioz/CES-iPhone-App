//
//  UCD_EventsAppDelegate.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UCD_EventsAppDelegate.h"

#import "BasicLauncherViewController.h"
#import "LocationListViewController.h"
#import "LocationDetailViewController.h"
#import "EventListViewController.h"
#import "EventDetailViewController.h"
#import "InfoViewController.h"
#import "OffersViewController.h"
#import "MapViewController.h"

@implementation UCD_EventsAppDelegate


@synthesize window=_window;

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TTExtensionLoader loadAllExtensions];
    UEStyleSheet *styleSheet = [[UEStyleSheet alloc] init];
    [styleSheet addStyleSheetFromDisk:TTPathForBundleResource(@"UCDEvents.css")];
    [TTStyleSheet setGlobalStyleSheet:styleSheet];
    
    TT_RELEASE_SAFELY(styleSheet);
    
    // Override point for customization after application launch.

    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
    
    TTURLCache *ttCache = [TTURLCache sharedCache];
    
    [ttCache setDisableDiskCache:YES];
    
    //  TTNavigator Setup
    
    TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeNone;
	TTURLMap* map = navigator.URLMap;
    
//  TTNavigator mappings
    
 	[map from:@"*" toViewController:[TTWebController class]];
	[map from:@"ucde://launcher/" toViewController:
	 [BasicLauncherViewController class]];
	[map from:@"ucde://locationList/(initWithName:)/(typeId:)/" toViewController:
	 [LocationListViewController class]];
    [map from:@"ucde://locations/(initWithLocationId:)" toViewController:
     [LocationDetailViewController class]];
    [map from:@"ucde://events/" toViewController:
     [EventListViewController class]];
    [map from:@"ucde://events/(initWithEventId:)" toViewController:
     [EventDetailViewController class]];
	[map from:@"ucde://info/" toViewController:
     [InfoViewController class]];
    [map from:@"ucde://offers/" toViewController:
     [OffersViewController class]];
    [map from:@"ucde://map/" toViewController:
     [MapViewController class]];
    //[map from:@"ucde://directions/(openURL:)/" toObject:UIApplication sharedApplication selector:@"openURL:"];

//  Push the first view: the launcher  
	if (![navigator restoreViewControllers]) {
		[[TTNavigator navigator] openURLAction:
		 [[TTURLAction actionWithURLPath:@"ucde://launcher"] applyAnimated:YES]];
	}
    
//    From http://stackoverflow.com/questions/3790957/reachability-guide-for-ios-4
    Reachability *reachable = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus status = [reachable currentReachabilityStatus];
    if (status == NotReachable) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Unable to connect" message:@"UCD Events was unable to connect to the UC Davis Events service. Parts of the app may not function." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
        [alert show];
    }
    
    return YES;
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}


@end
