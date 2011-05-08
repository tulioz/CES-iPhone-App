//
//  EmailViewController.h
//  UCDavis
//
//  Created by Fei Li on 12/4/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface EmailViewController : UIViewController<UIWebViewDelegate> {
	UIWebView *webView;
	//UIActivityIndicatorView *activityIndicator;
	NSString *urlString;
	NSString *titleString;
	NSURL *website;
	
	MBProgressHUD *progressHud;
}

- (IBAction)selectHome:(id)sender;

@property(nonatomic, retain) IBOutlet UIWebView *webView;
//@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain) NSString *urlString;
@property(nonatomic, retain) NSString *titleString;
@property(nonatomic, retain) NSURL *website;

@end
