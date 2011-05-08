//
//  AboutRootViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/4/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutRootViewController : UIViewController {
	UINavigationController *navigationController;
}

@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)selectHome:(id)sender;

@end
