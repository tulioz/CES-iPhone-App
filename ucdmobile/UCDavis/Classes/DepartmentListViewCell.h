//
//  DepartmentListViewCell.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/25/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DepartmentListViewCell : UITableViewCell {
	UILabel *abbreviationLabel;
	UILabel *departmentLabel;
}

@property(nonatomic, retain) IBOutlet UILabel *abbreviationLabel;
@property(nonatomic, retain) IBOutlet UILabel *departmentLabel;

@end
