//
//  LoadingViewController.h
//  Departments
//
//  Created by Sunny Dhillon on 10/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadingViewController : UIViewController {
	UILabel *loadingLabel;
	UIActivityIndicatorView *activityIndicatorView;
}

@property (nonatomic, copy) IBOutlet UILabel *loadingLabel;
@property (nonatomic, copy) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end
