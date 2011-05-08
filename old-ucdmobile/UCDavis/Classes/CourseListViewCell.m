//
//  CourseListViewCell.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/21/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CourseListViewCell.h"


@implementation CourseListViewCell

@synthesize titleLabel;
@synthesize courseLabel;

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
	[titleLabel release];
	[courseLabel release];
    [super dealloc];
}


@end
