//
//  MyAnnotation.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/5/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <MapKit/MapKit.h>


@interface MyAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subTitle;
}

@end
