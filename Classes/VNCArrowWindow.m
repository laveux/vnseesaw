//
//  VNCPoupWindow.m
//  vnsea
//
//  Created by Glenn Kreisel on 10/28/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "VNCArrowWindow.h"
#import "VNCArrowView.h"

#define kUpDirection 1
#define kDownDirection 2
#define kLeftDirection 3
#define kRightDirection 4
//! Height of the controls bar view.
#define kControlsBarHeight (48.0f)

@implementation VNCArrowWindow

- (id)initWithFrame:(CGRect)frame// centered:(BOOL)bCenter show:(BOOL)bShow orientation:(float)fOrientation style:(arrow_style_t)wStyle
{
//	if (bCenter)
//	{
//		CGRect rcWindow = [UIHardware fullScreenApplicationContentRect];
		
//		frame.origin.x = 0;//rcWindow.origin.x + ((rcWindow.size.width / 2) - (frame.size.width / 2));
//		frame.origin.y = 100;//rcWindow.size.height - frame.size.height - kControlsBarHeight;

//		CGRect superBounds = [super getFrame];
		
//NSLog(@"Position info: superBounds = (%f, %f, %f, %f); ", superBounds.origin.y, superBounds.origin.x, superBounds.size.height, superBounds.size.width);
//	}
		
	if ([super initWithFrame:frame])
	{
		UIImage* arrow;
		CGImageRef Image;
		float w, h;

		arrow = [UIImage imageNamed: @"upArrow.png"];
		Image = [arrow imageRef]; 
		w = (float) CGImageGetWidth(Image);
		h = (float) CGImageGetHeight(Image);
NSLog(@"image width = %f, height = %f", w, h);
NSLog(@"kUpDirection = %i", kUpDirection);
//		frame = CGRectMake (50, 50, w, h);
		_viewUpArrow = [[VNCArrowView alloc] initWithFrame:frame image:arrow direction:kUpDirection];// style:wStyle];
		[_viewUpArrow setBackgroundColor:GSColorCreateColorWithDeviceRGBA(0.0, 0.0, 0.0, 1.0)];
//		[_viewUpArrow drawRect:frame];
		[self addSubview:_viewUpArrow]; 
		
		arrow = [UIImage imageNamed: @"downArrow.png"];
NSLog(@"kDownDirection = %i", kDownDirection);
//		frame = CGRectMake (0, 50, w, h);
//		_viewDownArrow = [[VNCArrowView alloc] initWithFrame:frame image:arrow direction:kDownDirection];// style:wStyle];
//		[_viewDownArrow setBackgroundColor:GSColorCreateColorWithDeviceRGBA(0.0, 0.0, 0.0, 1.0)];
//		[_viewDownArrow drawRect:frame];
//		[self addSubview:_viewDownArrow];
//		[_viewDownArrow setNeedsDisplay];
		
//		_viewLeftArrow = [[VNCArrowView alloc] initWithFrame:frame direction:[UIImage imageNamed: @"leftArrow.png"] ];// style:wStyle];
//		[_viewLeftArrow setBackgroundColor:GSColorCreateColorWithDeviceRGBA(0.0, 0.0, 0.0, 1.0)];
//		[self setContentView:_viewLeftArrow]; 
		
//		_viewRightArrow = [[VNCArrowView alloc] initWithFrame:frame direction:[UIImage imageNamed: @"rightArrow.png"] ];// style:wStyle];
//		[_viewRightArrow setBackgroundColor:GSColorCreateColorWithDeviceRGBA(0.0, 0.0, 0.0, 1.0)];
//		[self setContentView:_viewRightArrow]; 
		
		[self orderFront:nil]; 
		[self makeKey:nil];
		[self setHidden:YES];
//NSLog(@"Arrow Orientation %f", fOrientation);
	}
	
	return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)setHidden:(BOOL)bHide
{
//NSLog(@"Set Hidden");
	[self _setHidden: bHide];
}

//- (void)setStyleWindow:(arrow_style_t)wStyle
//{
//	[_viewArrow setStyleWindow: wStyle];
//}

//- (void)setText:(NSString *)theText
//{
//NSLog(@"Set Text PopWindow");
//	[_viewArrow setText:theText];
//}

//- (void)setTextPercent:(float)fScale
//{
//NSLog(@"Text Percent %f", fScale);
//	[_viewArrow setText: [NSString stringWithFormat: @"%d%%", (int)(fScale * 100)]];
//}

- (void)setCenterLocation:(CGPoint)ptCenter
{
	CGRect rcFrame = [self frame];
	
	if (ptCenter.x != _ptCenterOld.x || ptCenter.y != _ptCenterOld.y)
	{
		CGRect rcWindow = [UIHardware fullScreenApplicationContentRect];
		
		rcFrame.origin.x = rcWindow.origin.x + (ptCenter.x - [self bounds].size.width / 2);
		rcFrame.origin.y = rcWindow.origin.y + ((ptCenter.y - [self bounds].size.height / 2));
		
		[self setFrame: rcFrame];
		_ptCenterOld = ptCenter;
	}
}

//- (void)handleArrowTimer:(NSTimer *)timer
//{	
//NSLog(@"Timer going Away");
//	VNCArrowWindow **pw = (VNCArrowWindow **)[timer userInfo];
//	[_viewArrow removeFromSuperview];
//	if (pw != nil)
//	{
//		*pw = nil;
//	}
//}

//- (void)setTimer:(float)fSeconds info:(VNCArrowWindow **)info
//{
//NSLog(@"In Setting Timer on Arrow");
//	_arrowTimer = [NSTimer scheduledTimerWithTimeInterval:fSeconds target:self selector:@selector(handleArrowTimer:) userInfo:nil repeats:NO];
//NSLog(@"Set Timer on Arrow");
//}

@end
