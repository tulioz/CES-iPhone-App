//
//  WebBrowserRootViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebBrowserRootViewController : UIViewController {
	UINavigationController *navigationController;
	NSURL *websiteURL;
}

@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property(nonatomic, retain) NSURL *websiteURL;

- (IBAction)selectHome:(id)sender;

@end
