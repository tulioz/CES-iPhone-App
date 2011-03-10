//
//  NewspaperDetailViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/23/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewspaperDetailViewController : UIViewController {
	NSDictionary *rssItem;
	
	UILabel *titleLabel;
	UILabel *pubDateLabel;
	UITextView *descriptionTextView;
	UILabel *spacerTopLeft;
	UILabel *spacerTopRight;
	UILabel *spacerBottomLeft;
	UILabel *spacerBottomRight;
}

@property(nonatomic, retain) NSDictionary *rssItem;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) IBOutlet UILabel *pubDateLabel;
@property(nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property(nonatomic, retain) IBOutlet UILabel *spacerTopLeft;
@property(nonatomic, retain) IBOutlet UILabel *spacerTopRight;
@property(nonatomic, retain) IBOutlet UILabel *spacerBottomLeft;
@property(nonatomic, retain) IBOutlet UILabel *spacerBottomRight;

- (IBAction)openRssLink:(id)sender;

@end
