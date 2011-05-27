//
//  UCD_EventsAppDelegate.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "extThree20CSSStyle/extThree20CSSStyle.h"
#import "BasicLauncherViewController.h"
#import "UCD_EventsViewController.h"
#import "UEStyleSheet.h"
#import "Reachability.h"

@interface UCD_EventsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UCD_EventsViewController *viewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
