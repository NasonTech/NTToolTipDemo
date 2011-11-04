//
//  CGEnhancements.h
//  NTToolTipDemo
//
//  Created by Brandon Nason on 11/3/11.
//  Copyright (c) 2011 Nason Tech. All rights reserved.
//

struct CGOffset {
	CGFloat top;
	CGFloat bottom;
	CGFloat left;
	CGFloat right;
};
typedef struct CGOffset CGOffset;

CGOffset CGOffsetMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left);
CGFloat CGOffsetGetWidth(CGOffset offset);
CGFloat CGOffsetGetHeight(CGOffset offset);