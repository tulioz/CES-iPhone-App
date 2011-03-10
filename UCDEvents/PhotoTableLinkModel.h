//
//  PhotoTableLinkModel.h
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface PhotoTableLinkModel : NSObject {
	NSString *linkTitle;
	NSString *linkImageName;
	NSString *linkURLName;
	UIImage *linkImage;
	TTURLAction *linkURL;
	
}

-(id) initWithTitle:(NSString *) newTitle
			  image:(NSString *) newImageName
				URL:(NSString *) newURLName;

@property (nonatomic, retain) NSString *linkTitle;
@property (nonatomic, retain) UIImage *linkImage;
@property (nonatomic, retain) TTURLAction *linkURL;
@property (nonatomic, retain) NSString *linkImageName;
@property (nonatomic, retain) NSString *linkURLName;


@end
