//
//  InformationRootViewController.h
//  UCDavis
//
//  Created by Fei Li on 10/18/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InformationRootViewController : UIViewController {
	UINavigationController *navigationController;
}

@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)selectHome:(id)sender;

@end
