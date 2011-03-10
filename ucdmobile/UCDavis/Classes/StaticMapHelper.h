//
//  GoogleStaticMapHelper.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

enum MapType {
	MapTypeRoadMap = 0,
	MapTypeSatellite,
	MapTypeHybrid,
};

@interface StaticMapHelper : NSObject {
	
}

+ (UIImage *)imageViewWithLatitude:(NSNumber *)lat longitude:(NSNumber *)lng mapType:(NSInteger)mapType marker:(Boolean)marker;
+ (UIImage *)cachedImageViewWithLatitude:(NSNumber *)lat longitude:(NSNumber *)lng mapType:(NSInteger)mapType marker:(Boolean)marker reuseIdentifier:(NSString *)name;

@end
