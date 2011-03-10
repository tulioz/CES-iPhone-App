//
//  ListViewCell.h
//  UCDavis
//
//  Created by Fei Li on 11/21/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListViewCell : UITableViewCell {
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *dateLabel;
	IBOutlet UILabel *descriptionLabel;	
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;

@end
