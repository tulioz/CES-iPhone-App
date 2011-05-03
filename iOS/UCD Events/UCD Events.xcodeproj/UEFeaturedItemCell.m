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
//        self.textLabel.font = TTSTYLEVAR(tableFont);
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
//        self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
//        self.textLabel.textAlignment = UITextAlignmentLeft;
//        self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
//        self.textLabel.adjustsFontSizeToFitWidth = YES;
//        
//        self.detailTextLabel.font = TTSTYLEVAR(font);
        self.detailTextLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
//        self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
//        self.detailTextLabel.textAlignment = UITextAlignmentLeft;
//        self.detailTextLabel.contentMode = UIViewContentModeTop;
//        self.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
//        self.detailTextLabel.numberOfLines = kTableMessageTextLineCount;
//        
//        self.textLabel.backgroundColor = [UIColor blueColor];
//        NSLog(@"Called initWithStyle for UEFeaturedItemCell!");
        TTView *bgView = [[TTView alloc] initWithFrame:[self frame]];
        bgView.style = TTSTYLEVAR(insetSquare);
        bgView.backgroundColor = [UIColor clearColor];
        self.backgroundView = bgView;
        TT_RELEASE_SAFELY(bgView);
        
//        TTView *selectedBgView = [[TTView alloc] initWithFrame:[self frame]];
//        self.selectedBackgroundView = selectedBgView;
//        TT_RELEASE_SAFELY(selectedBgView);
    }
    
    return self;
}

@end
