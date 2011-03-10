//
//  UIAlertHelper.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/9/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "UIAlertHelper.h"


@implementation UIAlertHelper

+ (void)networkErrorAlert {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Could not connect to server. Please try again when you have a network connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];	
}

+ (void)locationErrorAlert {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Location Error" message:@"Your location could not be determined." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];	
}

+ (void)mailErrorAlert {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mail Error" message:@"Could not find enabled email. Please try again when you have email enabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];	
}

@end
