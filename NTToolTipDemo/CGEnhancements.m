//
//  CGEnhancements.m
//  NTToolTipDemo
//
//  Created by Brandon Nason on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CGEnhancements.h"

CGOffset CGOffsetMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left)
{
	CGOffset offset;
	offset.top = top;
	offset.bottom = bottom;
	offset.right = right;
	offset.left = left;

	return offset;
}

CGFloat CGOffsetGetWidth(CGOffset offset)
{
	return offset.left + offset.right;
}

CGFloat CGOffsetGetHeight(CGOffset offset)
{
	return offset.top + offset.bottom;
}