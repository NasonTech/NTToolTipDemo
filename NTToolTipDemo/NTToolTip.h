// Copyright (c) 2011, Nason Tech.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
// 
// Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, TH
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

#import <UIKit/UIKit.h>
#import "NTCGEnhancements.h"

@interface NTToolTip : UIView

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) UIView *pointAt;
@property (nonatomic, retain) UIColor *fillColor;
@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) NTCGOffset padding;
@property (nonatomic, assign) NTCGOffset margin;
@property (nonatomic, assign) CGSize arrowSize;
@property (nonatomic, assign) NSInteger cornerRadius;
@property (nonatomic, assign) NSUInteger orientation;

enum
{
	NTToolTipOrientationAuto,
	NTToolTipOrientationTop,
	NTToolTipOrientationBottom,
	NTToolTipOrientationLeft,
	NTToolTipOrientationRight,
	NTToolTipOrientationNone,
};

typedef NSUInteger NTToolTipOrientation;

- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (id)initWithTitle:(NSString *)title message:(NSString *)message pointAt:(id)item;

- (void)showAnimated:(BOOL)animated;
- (void)show;
- (void)dismiss;

//- (CGPoint)calculateOriginInFrame:(CGRect)frame forSize:(CGSize)size;
- (void)drawRoundedRectWithArrow:(CGRect)rect inContext:(CGContextRef)context withRadius:(CGFloat)radius pointingAtFrame:(CGRect)frame;
- (void)animateToSize:(NSString *)id finished:(NSNumber *)finished context:(void *)context;

- (NSArray *)calculateOriginAndArrowPlacementForOrientation:(NTToolTipOrientation)orientation;
- (CGRect)calculateFrameForOrientation:(NTToolTipOrientation)orientation;
- (NTToolTipOrientation)calculateOrientation;

@end