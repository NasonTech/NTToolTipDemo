//
//  NTToolTip.h
//  NTToolTipDemo
//
//  Created by Brandon Nason on 11/3/11.
//  Copyright (c) 2011 Nason Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGEnhancements.h"

@interface NTToolTip : UIView

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) UIView *pointAt;
@property (nonatomic, retain) UIColor *fillColor;
@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) CGOffset padding;
@property (nonatomic, assign) CGOffset margin;
@property (nonatomic, assign) CGSize arrowSize;

- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (id)initWithTitle:(NSString *)title message:(NSString *)message pointAt:(id)item;

- (void)show;
- (void)showAnimated:(BOOL)animated;

- (void)dismiss;

- (void)drawRoundedRectWithArrow:(CGRect)rect inContext:(CGContextRef)context withRadius:(CGFloat)radius pointingAtFrame:(CGRect)frame;
- (void)animateToSize:(NSString *)id finished:(NSNumber *)finished context:(void *)context;

@end