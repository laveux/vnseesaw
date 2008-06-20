//
//  VNCArrowView.m
//  vnseesaw
//
//  Created by Eric Mockensturm on 5/20/08.
//  Copyright 2008 Small Feats. All rights reserved.
//

#import "VNCArrowView.h"
#import "VNCView.h"

@implementation VNCArrowView

- (id)initWithFrame:(CGRect)frame// image:(UIImage *)imageArrow direction:(int)dir
{
	if ([super initWithFrame:frame])
	{		
		UIImage* arrow;
		CGRect subframe;
		CGColorSpaceRef rgbSpace;
	
		// Mix a clear color.
		const float kClearComponents[] = { 0.2, 0.2, 0.2, 0 };
		rgbSpace = CGColorSpaceCreateDeviceRGB();
		CGColorRef clear = CGColorCreate(rgbSpace, kClearComponents);
		CGColorSpaceRelease(rgbSpace);

		subframe = CGRectMake (0, 0, 50, 50);
		_viewPageUp = [[UIPushButton alloc] initWithFrame:subframe];// style:wStyle];
		[_viewPageUp addTarget:_vncview action:@selector(sendPageUpKey:) forEvents:kUIControlEventMouseUpInside];
		[self addSubview:_viewPageUp]; 

		subframe = CGRectMake (50, 0, 50, 50);
		_viewUpArrow = [[UIPushButton alloc] initWithFrame:subframe];// style:wStyle];
		[_viewUpArrow addTarget:_vncview action:@selector(sendUpArrowKey:) forEvents:kUIControlEventMouseUpInside];
		[self addSubview:_viewUpArrow]; 

		subframe = CGRectMake (100, 0, 50, 50);
		_viewPageUp = [[UIPushButton alloc] initWithFrame:subframe];// style:wStyle];
		[_viewPageUp addTarget:_vncview action:@selector(sendHomeKey:) forEvents:kUIControlEventMouseUpInside];
		[self addSubview:_viewPageUp]; 

		subframe = CGRectMake (0, 50, 50, 50);
		_viewLeftArrow = [[UIPushButton alloc] initWithFrame:subframe];// style:wStyle];
		[_viewLeftArrow addTarget:_vncview action:@selector(sendLeftArrowKey:) forEvents:kUIControlEventMouseUpInside];
		[self addSubview:_viewLeftArrow]; 

		subframe = CGRectMake (100, 50, 50, 50);
		_viewRightArrow = [[UIPushButton alloc] initWithFrame:subframe];// style:wStyle];
		[_viewRightArrow addTarget:_vncview action:@selector(sendRightArrowKey:) forEvents:kUIControlEventMouseUpInside];
		[self addSubview:_viewRightArrow]; 

		subframe = CGRectMake (0, 100, 50, 50);
		_viewPageDown = [[UIPushButton alloc] initWithFrame:subframe];// style:wStyle];
		[_viewPageDown addTarget:_vncview action:@selector(sendPageDownKey:) forEvents:kUIControlEventMouseUpInside];
		[self addSubview:_viewPageDown]; 

		subframe = CGRectMake (50, 100, 50, 50);
		_viewDownArrow = [[UIPushButton alloc] initWithFrame:subframe];// style:wStyle];
		[_viewDownArrow addTarget:_vncview action:@selector(sendDownArrowKey:) forEvents:kUIControlEventMouseUpInside];
		[self addSubview:_viewDownArrow]; 

		subframe = CGRectMake (100, 100, 50, 50);
		_viewEnd = [[UIPushButton alloc] initWithFrame:subframe];// style:wStyle];
		[_viewEnd addTarget:_vncview action:@selector(sendEndKey:) forEvents:kUIControlEventMouseUpInside];
		[self addSubview:_viewEnd]; 

		[self setOpaque:NO];
		[self setBackgroundColor:clear];
		
		arrow = [UIImage imageNamed: @"ArrowButtons.png"];
		[self setImage:arrow];
	}
	return self;
}

- (void)dealloc
{
	[_imageArrow release];
	[super dealloc];
}

- (void)drawRect:(CGRect)destRect
{

}
@end
