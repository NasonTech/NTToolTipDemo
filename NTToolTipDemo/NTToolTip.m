//
//  NTToolTip.m
//  NTToolTipDemo
//
//  Created by Brandon Nason on 11/3/11.
//  Copyright (c) 2011 Nason Tech. All rights reserved.
//

#import "NTToolTip.h"
#import <QuartzCore/QuartzCore.h>

@implementation NTToolTip
{
	UILabel *titleLabel;
	UILabel *messageLabel;
}

@synthesize title = _title;
@synthesize message = _message;
@synthesize pointAt = _pointAt;
@synthesize fillColor = _fillColor;
@synthesize borderColor = _borderColor;
@synthesize textColor = _textColor;
@synthesize padding = _padding;
@synthesize margin = _margin;
@synthesize arrowSize = _arrowSize;

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
	self = [super init];
	if (self)
	{
		self.title = title;
		self.message = message;
		self.backgroundColor = [UIColor clearColor];
		self.fillColor = [UIColor colorWithRed:11/255.0 green:27/255.0 blue:68/255.0 alpha:0.80];
		self.borderColor = [UIColor colorWithRed:223/255.0 green:225/255.0 blue:230/255.0 alpha:1.0];
		self.padding = CGOffsetMake(15, 15, 15, 15);
		self.margin = CGOffsetMake(10, 10, 10, 10);
		self.arrowSize = CGSizeMake(20, 20);

		self.layer.shadowColor = [[UIColor blackColor] CGColor];
		self.layer.shadowOpacity = 0.7;
		self.layer.shadowOffset = CGSizeMake(0, 5);
		self.layer.shadowRadius = 3.0;
		self.clipsToBounds = NO;
		
		titleLabel = [[UILabel alloc] init];
		[titleLabel setText:self.title];
		[titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextColor:[UIColor whiteColor]];
		
		messageLabel = [[UILabel alloc] init];
		[messageLabel setText:self.message];
		[messageLabel setFont:[UIFont systemFontOfSize:17]];
		[messageLabel setBackgroundColor:[UIColor clearColor]];
		[messageLabel setTextColor:[UIColor whiteColor]];
		[messageLabel setLineBreakMode:UILineBreakModeWordWrap];
		[messageLabel setTextAlignment:UITextAlignmentCenter];
		[messageLabel setNumberOfLines:10];
	}
	return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message pointAt:(id)item
{
	if ([item isKindOfClass:[UIView class]])
		self.pointAt = item;
	else
		self.pointAt = [item valueForKey:@"view"];
	
	return [self initWithTitle:title message:message];
}

#define SPACING 20

//- (void)showInView:(UIView *)view pointAtFrame:(CGRect)frame animated:(BOOL)animted
- (void)showAnimated:(BOOL)animated
{
	UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
	for (UIWindow *window in [[UIApplication sharedApplication] windows])
		if (![NSStringFromClass([window class]) isEqualToString:@"_UIAlertNormalizingOverlayWindow"])
			mainWindow = window;
	
	CGRect windowFrame = [mainWindow frame];
	CGRect pointAtFrame = [self.pointAt.superview convertRect:self.pointAt.frame toView:nil];
	CGSize titleMinSize = [self.title sizeWithFont:titleLabel.font];
	CGSize messageMinSize = [self.message sizeWithFont:messageLabel.font constrainedToSize:CGSizeMake(windowFrame.size.width - CGOffsetGetWidth(self.margin) - CGOffsetGetWidth(self.padding) , 100) lineBreakMode:UILineBreakModeWordWrap];
	
	CGSize tooltipSize = CGSizeMake(MAX(titleMinSize.width, messageMinSize.width) + CGOffsetGetWidth(self.padding),
									titleMinSize.height + messageMinSize.height + CGOffsetGetHeight(self.padding) + self.arrowSize.height + ((titleMinSize.height > 0) ? (SPACING) : (0)));
	CGPoint location = CGPointMake(0, 0);
	//	if (CGRectGetMinX(pointAtFrame) < tooltipSize.height)
	//		location.y = CGRectGetMinY(pointAtFrame) - tooltipSize.height;
	//	else
	location.y = CGRectGetMaxY(pointAtFrame);
	
	if (CGRectGetMinX(pointAtFrame) < CGRectGetMidX(windowFrame))
		location.x = CGRectGetMinX(pointAtFrame);
	else
		location.x = CGRectGetMaxX(pointAtFrame) - tooltipSize.width;
	
	CGRect tooltipFrame = CGRectMake(location.x, location.y, tooltipSize.width, tooltipSize.height);
	[self setFrame:tooltipFrame];
	
	CGRect titleLabelFrame = CGRectMake(tooltipFrame.size.width / 2 - titleMinSize.width / 2,
										(titleMinSize.height > 0) ? (titleMinSize.height / 2 + self.padding.top + self.arrowSize.height) : (self.arrowSize.height),
										titleMinSize.width, titleMinSize.height);
	[titleLabel setFrame:titleLabelFrame];
	[self addSubview:titleLabel];
	
	CGRect messageLabelFrame = CGRectMake(tooltipFrame.size.width / 2 - messageMinSize.width / 2,
										  CGRectGetMaxY(titleLabel.frame) + ((titleMinSize.height > 0) ? (SPACING) : (self.padding.top)),
										  messageMinSize.width, messageMinSize.height);
	[messageLabel setFrame:messageLabelFrame];
	[self addSubview:messageLabel];
	
	[mainWindow addSubview:self];
	
	if (animated)
	{
		[self setAlpha:0.0];
		[UIView beginAnimations:@"ToolTipAppear" context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animateToSize:finished:context:)];
		self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.25, 1.25);
		[self setAlpha:1.0];
		[UIView commitAnimations];
	}
}

- (void)show
{
	[self showAnimated:YES];
}

- (void)animateToSize:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView beginAnimations:animationID context:context];
	self.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];
}

- (void)dismiss
{
	[self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect
{
	// Get drawing context
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Setup context
	CGContextClearRect(context, rect);
	CGContextSetAllowsAntialiasing(context, true);
	CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
	CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
	
	// Create new container rect
	CGRect containerRect = CGRectInset(CGRectMake(rect.origin.x, rect.origin.y + 20, rect.size.width, rect.size.height - 20), 2, 2);
	
	// Draw shape
	[self drawRoundedRectWithArrow:containerRect inContext:context withRadius:8 pointingAtFrame:self.pointAt.frame];
	CGContextSetLineWidth(context, 2.0);
	CGContextDrawPath(context, kCGPathFillStroke);
	
	// Draw center radial burst
	CGFloat colorsBurst[] = {
		1.0, 1.0, 1.0, 0.25,
		1.0, 1.0, 1.0, 0.00,
	};
	
	[self drawRoundedRectWithArrow:containerRect inContext:context withRadius:8 pointingAtFrame:self.pointAt.frame];
	CGContextClip(context);
	
	CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradientBurst = CGGradientCreateWithColorComponents(rgbColorspace, colorsBurst, NULL, 2);
	CGColorSpaceRelease(rgbColorspace), rgbColorspace = nil;
	
	CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
	CGContextDrawRadialGradient(context, gradientBurst, center, 0, center, rect.size.width, 0);
	CGGradientRelease(gradientBurst), gradientBurst = nil;
	
	// Top Highlight
	CGRect rectHighlight = CGRectMake(-50, -45 + 20, rect.size.width + 50 * 2, 75);
	CGContextAddEllipseInRect(context, rectHighlight);
	CGContextSetLineWidth(context, 0);
	CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
	CGContextSetAlpha(context, 0.25);
	CGContextDrawPath(context, kCGPathFill);
}

- (void)drawRoundedRectWithArrow:(CGRect)rect inContext:(CGContextRef)context withRadius:(CGFloat)radius pointingAtFrame:(CGRect)frame
{
	CGContextBeginPath(context);
	
	CGFloat minx = CGRectGetMinX(rect);
	CGFloat midx = CGRectGetMidX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
	
	CGFloat miny = CGRectGetMinY(rect);
	CGFloat midy = CGRectGetMidY(rect);
	CGFloat maxy = CGRectGetMaxY(rect);
	
	CGPoint arrowPoint = CGPointMake(maxx * 3/4, miny);
	
	CGContextMoveToPoint(context, arrowPoint.x - (self.arrowSize.width / 2), arrowPoint.y);
	CGContextAddLineToPoint(context, arrowPoint.x, arrowPoint.y - self.arrowSize.height);
	CGContextAddLineToPoint(context, arrowPoint.x + (self.arrowSize.height / 2), arrowPoint.y);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	
	CGContextClosePath(context);
}

@end