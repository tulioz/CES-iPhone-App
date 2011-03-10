//
//  CourseListViewCell.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/21/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CourseListViewCell : UITableViewCell {
	UILabel *courseLabel;
	UILabel *titleLabel;
}

@property(nonatomic, retain) IBOutlet UILabel *courseLabel;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;

@end
