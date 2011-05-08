//
//  ListViewCell.m
//  UCDavis
//
//  Created by Fei Li on 11/21/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "ListViewCell.h"


@implementation ListViewCell

@synthesize titleLabel;
@synthesize dateLabel;
@synthesize descriptionLabel;

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
    [super dealloc];
}


@end
