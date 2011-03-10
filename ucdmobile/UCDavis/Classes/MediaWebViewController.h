//
//  MediaWebViewController.h
//  UCDavis
//
//  Created by Fei Li on 11/22/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MediaWebViewController : UIViewController {
	UIWebView *webView;
	NSURL *website;
}

@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic, retain) NSURL *website;

@end
