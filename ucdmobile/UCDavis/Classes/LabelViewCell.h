//
//  PersonDetailViewCell.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/20/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LabelViewCell : UITableViewCell {
	UILabel *labelLabel;
	UILabel *textLabel;
}

@property(nonatomic, retain) IBOutlet UILabel *labelLabel;
@property(nonatomic, retain) IBOutlet UILabel *textLabel;

@end
