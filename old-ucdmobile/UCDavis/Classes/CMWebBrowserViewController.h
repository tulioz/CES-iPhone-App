//
//  CMWebBrowser.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CMWebBrowserViewController : UIViewController <UIWebViewDelegate> {
	NSURL *websiteURL;	
	UIWebView *webView;
	UIActivityIndicatorView *activityIndicatorView;
	UIBarButtonItem *backButton;
	UIBarButtonItem *forwardButton;
}

@property (nonatomic, retain) NSURL *websiteURL;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *forwardButton;

@end
