//
//  BasicLauncherViewController.h
//  TTSample
//
//  Created by William Binns-Smith on 1/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Three20Launcher/Three20Launcher.h"
#import "Three20/Three20.h"

@interface BasicLauncherViewController : TTViewController <TTLauncherViewDelegate> {
	TTLauncherView *launcherView;
}

@end
