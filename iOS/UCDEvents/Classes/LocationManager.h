//
//  LocationManager.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// Modeled after http://www.icodeblog.com/2010/09/03/adding-local-weather-conditions-to-your-app-part-12-implementing-corelocation/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate

@required
-(void)updateLocation:(CLLocation *)newLocation;

@end


@interface LocationManager : NSObject {
	CLLocationManager *locationHandler;
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationHandler;
@property (nonatomic, retain) id delegate;

@end
