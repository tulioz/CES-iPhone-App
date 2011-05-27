//
//  UEFeaturedItemCell.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UEFeaturedItemCell.h"


@implementation UEFeaturedItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.backgroundColor = [UIColor clearColor];

        self.detailTextLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];

        TTView *bgView = [[TTView alloc] initWithFrame:[self frame]];
        bgView.style = TTSTYLEVAR(insetSquare);
        bgView.backgroundColor = [UIColor clearColor];
        self.backgroundView = bgView;
        TT_RELEASE_SAFELY(bgView);
    }
    
    return self;
}

@end
