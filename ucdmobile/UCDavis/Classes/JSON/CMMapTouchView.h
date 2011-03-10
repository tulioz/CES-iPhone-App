//
//  CMMapTouchView.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CMMapTouchView : UIView {
    UIView *viewTouched;
}

@property (nonatomic, retain) UIView * viewTouched;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
