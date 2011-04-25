//
//  BasicLauncherViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "UELauncherView.h"

@interface BasicLauncherViewController : TTViewController <TTLauncherViewDelegate> 
{
    UELauncherView *launcherView;
    
}

@end
