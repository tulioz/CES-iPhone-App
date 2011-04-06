//
//  LocationManager.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// Modeled after http://www.icodeblog.com/2010/09/03/adding-local-weather-conditions-to-your-app-part-12-implementing-corelocation/
// Singleton modeled after http://stackoverflow.com/questions/459355/whats-the-easiest-way-to-get-the-current-location-of-an-iphone
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject {
	CLLocationManager *locationHandler;
	CLLocation *lastLocation;
}

+(LocationManager *)sharedInstance;
-(void)stopUpdates;
-(void)startUpdates;
-(BOOL)locationKnown;

@property (nonatomic, retain) CLLocationManager *locationHandler;
@property (nonatomic, retain) CLLocation *lastLocation;

@end
