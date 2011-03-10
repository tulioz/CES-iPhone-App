//
//  UIAlertHelper.h
//  UCDavis
//
//  Created by Sunny Dhillon on 1/9/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIAlertHelper : NSObject {

}

+ (void)networkErrorAlert;
+ (void)locationErrorAlert;
+ (void)mailErrorAlert;

@end
