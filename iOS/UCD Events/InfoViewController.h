//
//  InfoViewController.h
//  UCD Events
//
//  Created by Ofer Goldstein on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@interface InfoViewController : TTTableViewController {
    
}

-(NSString *) formatPhoneString:(NSString *) rawString;
-(NSString* )openGoogleMapsWithDestinationLatitude:(NSString *)latitude longitude:(NSString *)longitude;

@end
