//
//  NewsRootViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewspaperRootViewController : UIViewController {
	UINavigationController *navigationController;
}

@property(nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction)selectHome:(id)sender;

@end
