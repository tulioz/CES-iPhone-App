//
//  EmailRootViewController.h
//  UCDavis
//
//  Created by Fei Li on 1/3/10.
//  Copyright 2010 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EmailRootViewController : UIViewController {
	UINavigationController *navigationController;
}

@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)selectHome:(id)sender;

@end
