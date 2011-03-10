//
//  MapRootViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/4/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapRootViewController : UIViewController {
	UINavigationController *navigationController;
}

@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)selectHome:(id)sender;

@end
