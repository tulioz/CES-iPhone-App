//
//  StopAnnotation.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/13/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMAnnotation.h"

@class GTStop;

@interface StopAnnotation : CMAnnotation {
	GTStop *stop;
}

@property(nonatomic, retain) GTStop *stop;

- (id)initWithStop:(GTStop *)theStop;

@end
