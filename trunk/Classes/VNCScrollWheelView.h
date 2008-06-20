//
//  VNCScrollWheelView.h
//  VNSeeSaw
//
//  Created by Eric Mockensturm on 5/30/08.
//  Copyright 2008 Penn State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventFilter.h"

@interface VNCScrollWheelView : UIPushButton {

float			_priorEventLocationY;
EventFilter*	_eventFilter;

}

//- (float)getDeltaY;
- (void)setEventFilter:(EventFilter *)filter;

@end
