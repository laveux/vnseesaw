/* Profile.m created by helmut on Fri 25-Jun-1999 */

/* Copyright (C) 1998-2000  Helmut Maierhofer <helmut.maierhofer@chello.at>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

#import "Profile.h"
#import "NSObject_Chicken.h"
//#import "ProfileManager.h"
#import "FrameBuffer.h"
//#import <Carbon/Carbon.h>

static const NSString* gEncodingNames[NUMENCODINGS] = {
	@"ZRLE",
    @"Tight",
	@"Zlib",
	@"ZlibHex",
    @"Hextile",
    @"CoRRE",
    @"RRE",
    @"Raw"
};


const unsigned int gEncodingValues[NUMENCODINGS] = {
	rfbEncodingZRLE,
	rfbEncodingTight,
	rfbEncodingZlib,
	rfbEncodingZlibHex,
	rfbEncodingHextile,
    rfbEncodingCoRRE,
    rfbEncodingRRE,
    rfbEncodingRaw
};

// --- Dictionary Keys --- //
NSString *kProfile_PixelFormat_Key = @"PixelFormat";
NSString *kProfile_EnableCopyrect_Key = @"EnableCopyRect";
NSString *kProfile_Encodings_Key = @"Encodings";
NSString *kProfile_EncodingValue_Key = @"ID";
NSString *kProfile_EncodingEnabled_Key = @"Enabled";
NSString *kProfile_LocalAltModifier_Key = @"NewAltKey";
NSString *kProfile_LocalCommandModifier_Key = @"NewCommandKey";
NSString *kProfile_LocalControlModifier_Key = @"NewControlKey";
NSString *kProfile_LocalShiftModifier_Key = @"NewShiftKey";
NSString *kProfile_Button2EmulationScenario_Key = @"Button2EmulationScenario";
NSString *kProfile_Button3EmulationScenario_Key = @"Button3EmulationScenario";
NSString *kProfile_ClickWhileHoldingModifierForButton2_Key = @"ClickWhileHoldingModifierForButton2";
NSString *kProfile_ClickWhileHoldingModifierForButton3_Key = @"ClickWhileHoldingModifierForButton3";
NSString *kProfile_MultiTapModifierForButton2_Key = @"MultiTapModifierForButton2";
NSString *kProfile_MultiTapModifierForButton3_Key = @"MultiTapModifierForButton3";
NSString *kProfile_MultiTapDelayForButton2_Key = @"MultiTapDelayForButton2";
NSString *kProfile_MultiTapDelayForButton3_Key = @"MultiTapDelayForButton3";
NSString *kProfile_MultiTapCountForButton2_Key = @"MultiTapCountForButton2";
NSString *kProfile_MultiTapCountForButton3_Key = @"MultiTapCountForButton3";
NSString *kProfile_TapAndClickModifierForButton2_Key = @"TapAndClickModifierForButton2";
NSString *kProfile_TapAndClickModifierForButton3_Key = @"TapAndClickModifierForButton3";
NSString *kProfile_TapAndClickButtonSpeedForButton2_Key = @"TapAndClickButtonSpeedForButton2";
NSString *kProfile_TapAndClickButtonSpeedForButton3_Key = @"TapAndClickButtonSpeedForButton3";
NSString *kProfile_TapAndClickTimeoutForButton2_Key = @"TapAndClickTimeoutForButton2";
NSString *kProfile_TapAndClickTimeoutForButton3_Key = @"TapAndClickTimeoutForButton3";
NSString *kProfile_IsDefault_Key = @"IsDefault";

static NSTimeInterval
DoubleClickInterval()
{
//	SInt16 ticks = LMGetKeyThresh();
	SInt16 ticks = 60;
	return (NSTimeInterval)ticks * 1.0/60.0;
}


static inline unsigned int
ButtonNumberToArrayIndex( unsigned int buttonNumber )
{
	NSCParameterAssert( buttonNumber == 2 || buttonNumber == 3 );
	return buttonNumber - 2;
}


@implementation Profile

+ (int)_indexForEncodingType: (CARD32)type
{
	int i;
	
	for ( i = 0; i < NUMENCODINGS; ++i )
		if ( gEncodingValues[i] == type )
			return i;
	[NSException raise: NSInternalInconsistencyException format: @"Bad encoding type given, no corresponding index"];
	return -1; // never executed
}

+ (NSString *)nameForEncodingType: (CARD32)type
{
	int index = [self _indexForEncodingType: type];
	return (NSString *)gEncodingNames[index];
}


+ (CARD32)modifierCodeForPreference: (id)preference
{
	switch ([preference shortValue])
	{
		case kRemoteAltModifier:
			return kAltKeyCode;
		case kRemoteMetaModifier:
			return kMetaKeyCode;
		case kRemoteControlModifier:
			return kControlKeyCode;
		case kRemoteShiftModifier:
			return kShiftKeyCode;
		case kRemoteWindowsModifier:
			return kWindowsKeyCode;
	}
	[NSException raise: NSInternalInconsistencyException format: @"Invalid modifier code"];
	return 0; // never executed
	
}

+ (Profile *)defaultProfile
{
	return [[[Profile alloc] initWithDictionary:[NSDictionary dictionary] name:@"Default"] autorelease];
}

- (id)initWithDictionary:(NSDictionary*)d name: (NSString *)name
{
    if (self = [super init]) {
//		NSArray* enc;
//		int i;

		info = [[d deepMutableCopy] retain];
		[info setObject: name forKey: @"ProfileName"];
		
		// we're guaranteed that all keys are present
//		commandKeyCode = [ProfileManager modifierCodeForPreference: 
//			[info objectForKey: kProfile_LocalCommandModifier_Key]];
//		
//		altKeyCode = [ProfileManager modifierCodeForPreference: 
//			[info objectForKey: kProfile_LocalAltModifier_Key]];
//		
//		shiftKeyCode = [ProfileManager modifierCodeForPreference: 
//			[info objectForKey: kProfile_LocalShiftModifier_Key]];
//		
//		controlKeyCode = [ProfileManager modifierCodeForPreference: 
//			[info objectForKey: kProfile_LocalControlModifier_Key]];
		
//		enc = [info objectForKey: kProfile_Encodings_Key];
//		if( YES == [[info objectForKey: kProfile_EnableCopyrect_Key] boolValue] ) {
//			numberOfEnabledEncodings = 2;
//			enabledEncodings[0] = rfbEncodingCopyRect;
//			enabledEncodings[1] = rfbEncodingQualityLevel6; // hardcoding in jpeg support, this should be a selection
//		} else {
//			numberOfEnabledEncodings = 0;
//		}
//		for(i=0; i<[enc count]; i++) {
//			NSDictionary *e = [enc objectAtIndex:i];
//			if ( [[e objectForKey: kProfile_EncodingEnabled_Key] boolValue] )
//				enabledEncodings[numberOfEnabledEncodings++] = [[e objectForKey: kProfile_EncodingValue_Key] intValue];
//		}
		
		numberOfEnabledEncodings = 10;
		enabledEncodings[0] = rfbEncodingZRLE;
		enabledEncodings[1] = rfbEncodingTight;
		enabledEncodings[2] = rfbEncodingZlib;
		enabledEncodings[3] = rfbEncodingZlibHex;
		enabledEncodings[4] = rfbEncodingHextile;
		enabledEncodings[5] = rfbEncodingCoRRE;
		enabledEncodings[6] = rfbEncodingRRE;
		enabledEncodings[7] = rfbEncodingRaw;
		enabledEncodings[8] = rfbEncodingCopyRect;
		enabledEncodings[9] = rfbEncodingQualityLevel6;

		_button2EmulationScenario = kNoMouseButtonEmulation; //(EventFilterEmulationScenario)[[info objectForKey: kProfile_Button2EmulationScenario_Key] intValue];
		
		_button3EmulationScenario = kNoMouseButtonEmulation; //(EventFilterEmulationScenario)[[info objectForKey: kProfile_Button3EmulationScenario_Key] intValue];
		
		_clickWhileHoldingModifier[0] = 0; //[[info objectForKey: kProfile_ClickWhileHoldingModifierForButton2_Key] unsignedIntValue];
		
		_clickWhileHoldingModifier[1] = 0; //[[info objectForKey: kProfile_ClickWhileHoldingModifierForButton3_Key] unsignedIntValue];
		
		_multiTapModifier[0] = 0; //[[info objectForKey: kProfile_MultiTapModifierForButton2_Key] unsignedIntValue];
		
		_multiTapModifier[1] = 0; //[[info objectForKey: kProfile_MultiTapModifierForButton3_Key] unsignedIntValue];
		
//		_multiTapDelay[0] = (NSTimeInterval)[[info objectForKey: kProfile_MultiTapDelayForButton2_Key] doubleValue];
//		if ( 0.0 == _multiTapDelay[0] )
			_multiTapDelay[0] = DoubleClickInterval();
		
//		_multiTapDelay[1] = (NSTimeInterval)[[info objectForKey: kProfile_MultiTapDelayForButton3_Key] doubleValue];
//		if ( 0.0 == _multiTapDelay[1] )
			_multiTapDelay[1] = DoubleClickInterval();
		
		_multiTapCount[0] = 0; //[[info objectForKey: kProfile_MultiTapCountForButton2_Key] unsignedIntValue];
		
		_multiTapCount[1] = 0; //[[info objectForKey: kProfile_MultiTapCountForButton3_Key] unsignedIntValue];
		
		_tapAndClickModifier[0] = 0; //[[info objectForKey: kProfile_TapAndClickModifierForButton2_Key] unsignedIntValue];
		
		_tapAndClickModifier[1] = 0; //[[info objectForKey: kProfile_TapAndClickModifierForButton3_Key] unsignedIntValue];
		
//		_tapAndClickButtonSpeed[0] = (NSTimeInterval)[[info objectForKey: kProfile_TapAndClickButtonSpeedForButton2_Key] doubleValue];
//		if ( 0.0 == _tapAndClickButtonSpeed[0] )
			_tapAndClickButtonSpeed[0] = DoubleClickInterval();
		
//		_tapAndClickButtonSpeed[1] = (NSTimeInterval)[[info objectForKey: kProfile_TapAndClickButtonSpeedForButton3_Key] doubleValue];
//		if ( 0.0 == _tapAndClickButtonSpeed[1] )
			_tapAndClickButtonSpeed[1] = DoubleClickInterval();
		
		_tapAndClickTimeout[0] = 0; //(NSTimeInterval)[[info objectForKey: kProfile_TapAndClickTimeoutForButton2_Key] doubleValue];
		
		_tapAndClickTimeout[1] = 0; //(NSTimeInterval)[[info objectForKey: kProfile_TapAndClickTimeoutForButton3_Key] doubleValue];
		
	}
    return self;
}

- (void)dealloc
{
    [info release];
    [super dealloc];
}

- (NSString*)profileName
{
    return [info objectForKey:@"ProfileName"];
}

- (CARD32)commandKeyCode
{
    return kAltKeyCode; //commandKeyCode;
}

- (CARD32)altKeyCode // option
{
    return kMetaKeyCode; //altKeyCode;
}

- (CARD32)shiftKeyCode
{
    return kShiftKeyCode; //shiftKeyCode;
}

- (CARD32)controlKeyCode
{
    return kControlKeyCode; //controlKeyCode;
}

- (CARD16)numberOfEnabledEncodings
{
    return numberOfEnabledEncodings;
}

- (CARD32)encodingAtIndex:(unsigned)index
{
    return enabledEncodings[index];
}

- (BOOL)useServerNativeFormat
{
//    int i = [[info objectForKey: kProfile_PixelFormat_Key] intValue];
//
//    return (i == 0) ? YES : NO;
	return NO;
}

- (void)getPixelFormat:(rfbPixelFormat*)format
{
    int i = 2; //[[info objectForKey: kProfile_PixelFormat_Key] intValue];

    format->bigEndian = [FrameBuffer bigEndian];
    format->trueColour = YES;
    switch(i) {
        case 0:
            break;
        case 1:
            format->bitsPerPixel = 8;
            format->depth = 8;
            format->redMax = format->greenMax = format->blueMax = 3;
            format->redShift = 6;
            format->greenShift = 4;
            format->blueShift = 2;
            break;
        case 2:
            format->bitsPerPixel = 16;
            format->depth = 16;
            format->redMax = format->greenMax = format->blueMax = 15;
            if(format->bigEndian) {
                format->redShift = 12;
                format->greenShift = 8;
                format->blueShift = 4;
            } else {
                format->redShift = 4;
                format->greenShift = 0;
                format->blueShift = 12;
            }
            break;
        case 3:
            format->bitsPerPixel = 32;
            format->depth = 24;
            format->redMax = format->greenMax = format->blueMax = 255;
            if(format->bigEndian) {
                format->redShift = 16;
                format->greenShift = 8;
                format->blueShift = 0;
            } else {
                format->redShift = 0;
                format->greenShift = 8;
                format->blueShift = 16;
            }
            break;
    }
}

- (EventFilterEmulationScenario)button2EmulationScenario
{  return _button2EmulationScenario;  }

- (EventFilterEmulationScenario)button3EmulationScenario
{  return _button3EmulationScenario;  }

- (unsigned int)clickWhileHoldingModifierForButton: (unsigned int)button
{
	unsigned int buttonIndex = ButtonNumberToArrayIndex( button );
	return _clickWhileHoldingModifier[buttonIndex];
}

- (unsigned int)multiTapModifierForButton: (unsigned int)button
{
	unsigned int buttonIndex = ButtonNumberToArrayIndex( button );
	return _multiTapModifier[buttonIndex];
}

- (NSTimeInterval)multiTapDelayForButton: (unsigned int)button
{
	unsigned int buttonIndex = ButtonNumberToArrayIndex( button );
	return _multiTapDelay[buttonIndex];
}

- (unsigned int)multiTapCountForButton: (unsigned int)button
{
	unsigned int buttonIndex = ButtonNumberToArrayIndex( button );
	return _multiTapCount[buttonIndex];
}

- (unsigned int)tapAndClickModifierForButton: (unsigned int)button
{
	unsigned int buttonIndex = ButtonNumberToArrayIndex( button );
	return _tapAndClickModifier[buttonIndex];
}

- (NSTimeInterval)tapAndClickButtonSpeedForButton: (unsigned int)button
{
	unsigned int buttonIndex = ButtonNumberToArrayIndex( button );
	return _tapAndClickButtonSpeed[buttonIndex];
}

- (NSTimeInterval)tapAndClickTimeoutForButton: (unsigned int)button
{
	unsigned int buttonIndex = ButtonNumberToArrayIndex( button );
	return _tapAndClickTimeout[buttonIndex];
}

@end
