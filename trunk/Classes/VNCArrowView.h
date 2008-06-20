//
//  VNCArrowView.h
//  vnsea
//
//  Created by Glenn Kreisel on 10/28/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameBuffer.h"
#import "VNCScrollerView.h"

/*!
 * @brief View class that draws a message bubble.
 */
@interface VNCArrowView : UIImageView
{
	NSString * _bubbleText;			//!< Text to draw inside the arrow bubble.
//	arrow_style_t _styleWindow;	//!< Selected drawing style.
	UIImage *_imageArrow;
	UIPushButton* _viewUpArrow;
	UIPushButton* _viewDownArrow;
	UIPushButton* _viewLeftArrow;
	UIPushButton* _viewRightArrow;
	UIPushButton* _viewPageUp;
	UIPushButton* _viewPageDown;
	UIPushButton* _viewHome;
	UIPushButton* _viewEnd;
	int _direction;
	VNCView* _vncview;
}

- (id)initWithFrame:(CGRect)frame;// image:(UIImage *)imageArrow direction:(int) direction;

- (void)drawRect:(CGRect)destRect;

@end
