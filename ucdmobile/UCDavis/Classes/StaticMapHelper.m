//
//  GoogleStaticMapHelper.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "StaticMapHelper.h"

#define imageURLFormat @"http://maps.google.com/maps/api/staticmap?center=%@,%@&zoom=15&size=64x64&maptype=%@&sensor=false&key=ABQIAAAARhNInCnTqOq8uJOIG_a3WhQCy4r7BRAtX35exi3_sdQy8bEk5BRGHcoL9Dn45RXCYCuva0mq-GJUgQ"

@implementation StaticMapHelper

+ (NSString *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

+ (UIImage *)imageViewWithLatitude:(NSNumber *)lat longitude:(NSNumber *)lng mapType:(NSInteger)mapType marker:(Boolean)marker {
	NSString *mapTypeParameter = nil;
	switch (mapType) {
		case MapTypeRoadMap:
			mapTypeParameter = @"roadmap";
			break;
		case MapTypeSatellite:
			mapTypeParameter = @"satellite";
			break;
		case MapTypeHybrid:
			mapTypeParameter = @"hybrid";
			break;			
		default:
			mapTypeParameter = @"roadmap";
			break;
	}
	NSMutableString *urlString = [[NSMutableString alloc] init];
	[urlString appendFormat:imageURLFormat, lat, lng, mapTypeParameter];
	if(marker) {
		[urlString appendFormat:@"&markers=size:small|%@,%@", lat, lng]; // 0x7C == |
	}
	NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[urlString release];
	
	return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
}

+ (UIImage *)cachedImageViewWithLatitude:(NSNumber *)lat longitude:(NSNumber *)lng mapType:(NSInteger)mapType marker:(Boolean)marker reuseIdentifier:(NSString *)name {
	NSString *filePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
	// check cache
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSLog(@"cached");
		return [UIImage imageWithContentsOfFile:filePath];
	}
	UIImage *image = [self imageViewWithLatitude:lat longitude:lng mapType:mapType marker:marker];
	// cache image
	if(image != nil) {
		[UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
	}
	return image;
}

@end
