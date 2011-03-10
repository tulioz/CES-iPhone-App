//
//  AthleticsRootListController.h
//  UCDavis
//
//  Created by Fei Li on 11/21/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AthleticsRootListController : UITableViewController {
	NSArray *rows;
	NSDictionary *feedDictionary;
}

@property (nonatomic, retain) NSArray *rows;
@property (nonatomic, retain) NSDictionary *feedDictionary;

@end
