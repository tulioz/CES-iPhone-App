//
//  MediaRadioViewController.h
//  UCDavis
//
//  Created by Fei Li on 2/13/10.
//  Copyright 2010 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MediaRadioViewController : UIViewController {
	UIWebView *webView;
	NSURL *website;
}

@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic, retain) NSURL *website;

@end
