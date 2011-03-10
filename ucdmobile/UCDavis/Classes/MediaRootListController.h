//
//  MediaRootListController.h
//  UCDavis
//
//  Created by Fei Li on 11/22/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MediaListViewController;
@class MediaRadioViewController;

@interface MediaRootListController : UITableViewController {
	NSArray *rows;
	NSDictionary *feedDictionary;
	
	MediaRadioViewController *kdvsViewController;
	MediaListViewController *aggieTvViewController;
	MediaListViewController *davisYoutubeViewController;
}

@property (nonatomic, retain) NSArray *rows;
@property (nonatomic, retain) NSDictionary *feedDictionary;

@property (nonatomic, retain) MediaRadioViewController *kdvsViewController;
@property (nonatomic, retain) MediaListViewController *aggieTvViewController;
@property (nonatomic, retain) MediaListViewController *davisYoutubeViewController;

@end
