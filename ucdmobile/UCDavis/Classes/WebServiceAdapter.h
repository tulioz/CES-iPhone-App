//
//  WebServiceAdapter.h
//  UCDavis
//
//  Created by Sunny Dhillon on 10/14/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceAdapter : NSObject {
	
}

+ (NSArray *)fetchFeedByUrl:(NSURL *)feedURL;

@end
