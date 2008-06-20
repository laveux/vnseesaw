//
//  VNCArrowWindow.h
//  vnsea
//
//  Created by Glenn Kreisel on 10/28/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameBuffer.h"
#import "VNCArrowView.h"

@class VNCScrollerView;

/*!
 * @brief Window that hosts a arrow message bubble.
 */
@interface VNCArrowWindow : UIWindow
{
	UIView* _viewUpArrow;
	VNCArrowView *_viewDownArrow;
	VNCArrowView *_viewLeftArrow;
	VNCArrowView *_viewRightArrow;
	CGPoint _ptCenterOld;
	NSTimer *_arrowTimer;
	VNCScrollerView *_scroller;
}

- (id)initWithFrame:(CGRect)frame;// centered:(BOOL)bCenter show:(BOOL)bShow orientation:(float)fOrientaion style:(arrow_style_t)wStyle;

- (void)setHidden:(BOOL)bHide;
//- (void)setTextPercent:(float)fScale;
//- (void)setText:(NSString *)theText;
- (void)setCenterLocation:(CGPoint)ptCenter;
//- (void)setStyleWindow:(arrow_style_t)wStyle;

//- (void)setTimer:(float)fSeconds info:(VNCArrowWindow **)info;

@end
