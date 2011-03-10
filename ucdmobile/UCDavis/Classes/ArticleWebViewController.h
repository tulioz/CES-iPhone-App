//
//  ArticleWebViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/23/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface ArticleWebViewController : UIViewController<UIWebViewDelegate> {
	UIWebView *webView;
	NSURL *website;
	MBProgressHUD *progressHud;
}

@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic, retain) NSURL *website;

@end
