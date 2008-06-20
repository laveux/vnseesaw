//
//  VNCScrollWheelView.m
//  VNSeeSaw
//
//  Created by Eric Mockensturm on 5/30/08.
//  Copyright 2008 Penn State University. All rights reserved.
//

#import "VNCScrollWheelView.h"


@implementation VNCScrollWheelView


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		UIImage* scrollWheel;
		CGColorSpaceRef rgbSpace;
	
		// Mix a clear gray color.
		const float kClearGrayComponents[] = { 0.2, 0.2, 0.2, 0.5 };
		rgbSpace = CGColorSpaceCreateDeviceRGB();
		CGColorRef clearGray = CGColorCreate(rgbSpace, kClearGrayComponents);
		CGColorSpaceRelease(rgbSpace);

		[self setOpaque:YES];
		[self setBackgroundColor:clearGray];
		
		_priorEventLocationY = 0.0;
		
//		[self addTarget:_vncview action:@selector(sendScrollWheel:) forEvents:kUIControlEventMouseMovedInside];

//		arrow = [UIImage imageNamed: @"ArrowButtons.png"];
//		[self setImage:arrow];
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	// Drawing code
}

- (void)setEventFilter:(EventFilter *)filter
{
//NSLog(@"setting event filter");
	_eventFilter = filter;
}

- (void)mouseDragged:(GSEventRef)theEvent {
	CGRect eventRect = GSEventGetLocationInWindow(theEvent);
	float eventLocationY = eventRect.origin.y;
	
	if (_priorEventLocationY > 0.0) {
		float deltaY = eventLocationY - _priorEventLocationY;
//NSLog(@"scroll view deltaY = %f",deltaY);
		[_eventFilter scrollWheel:theEvent amount:deltaY];
	}
	
	_priorEventLocationY = eventLocationY;
}


- (void)mouseUp:(GSEventRef)theEvent {
//NSLog(@"mouse up");
	_priorEventLocationY = 0.0;
}

- (void)dealloc {
	[super dealloc];
}


@end
