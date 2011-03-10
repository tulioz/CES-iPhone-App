//
//  DirectoryRootViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/9/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectoryRootViewController : UIViewController {
	UINavigationController *navigationController;
}

@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)selectHome:(id)sender;

@end
