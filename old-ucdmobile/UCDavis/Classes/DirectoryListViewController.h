//
//  DirectoryListViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/9/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface DirectoryListViewController : UITableViewController <UISearchBarDelegate> {
	UISearchBar *peopleSearchBar;
	
	NSOperationQueue *operationQueue;
	
	NSMutableDictionary *peopleDictionary;
	NSArray *sectionTitles;
	MBProgressHUD *progressHud;
}

@property(nonatomic, retain) IBOutlet UISearchBar *peopleSearchBar;
@property(nonatomic, retain) NSMutableDictionary *peopleDictionary;
@property(nonatomic, retain) NSArray *sectionTitles;

- (void)searchForPersonWithName:(NSString *)name;

@end
