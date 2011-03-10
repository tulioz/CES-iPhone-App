//
//  CMMapTouchView.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CMMapTouchView.h"


@implementation CMMapTouchView

@synthesize viewTouched;

//The basic idea here is to intercept the view which is sent back as the firstresponder in hitTest.
//We keep it preciously in the property viewTouched and we return our view as the firstresponder.
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	for(UIView *subView in self.subviews) {
		//[subView hitTest:point withEvent:event];
	}
    NSLog(@"Hit Test");
    return self;
}

//Then, when an event is fired, we log this one and then send it back to the viewTouched we kept, and voilà!!! :)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touch Began");
	for(UIView *subView in self.subviews) {
		[subView touchesBegan:touches withEvent:event];
	}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touch Moved");
	for(UIView *subView in self.subviews) {
		[subView touchesMoved:touches withEvent:event];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touch Ended");
	for(UIView *subView in self.subviews) {
		[subView touchesEnded:touches withEvent:event];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touch Cancelled");
	for(UIView *subView in self.subviews) {
		[subView touchesCancelled:touches withEvent:event];
	}
	
}

@end
