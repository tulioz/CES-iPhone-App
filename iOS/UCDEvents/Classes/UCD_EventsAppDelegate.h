//
//  UCD_EventsAppDelegate.h
//  UCD Events
//
//  Created by William Binns-Smith on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "LocationItem.h"
#import "LocationManager.h"

@class UCD_EventsViewController;

@interface UCD_EventsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UCD_EventsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UCD_EventsViewController *viewController;

-(NSURL *)applicationDocumentsDirectory;
-(void)saveContext;

@end

