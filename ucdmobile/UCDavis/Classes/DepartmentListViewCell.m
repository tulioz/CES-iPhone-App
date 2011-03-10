//
//  DepartmentListViewCell.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/25/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "DepartmentListViewCell.h"


@implementation DepartmentListViewCell

@synthesize abbreviationLabel;
@synthesize departmentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[abbreviationLabel release];
	[departmentLabel release];
    [super dealloc];
}


@end
