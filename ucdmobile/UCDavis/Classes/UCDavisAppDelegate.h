//
//  UCDavisAppDelegate.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/12/09.
//  Copyright gunrockstudios.com 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface UCDavisAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end

