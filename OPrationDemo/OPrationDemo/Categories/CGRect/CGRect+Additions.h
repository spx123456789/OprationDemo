//
//  CGRect+Additions.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

// 通过CGSize创建CGRect
static __inline__ CGRect CGRectFromCGSize(CGSize size) { return CGRectMake(0, 0, size.width, size.height); };

// 通过中心点CGPoint及CGSize创建CGRect
static __inline__ CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size) {
    return CGRectMake(center.x - size.width * 0.5, center.y - size.height * 0.5, size.width, size.height);
};

// 通过原点CGPoint及CGSize创建CGRect
static __inline__ CGRect CGRectMakeWithOriginAndSize(CGPoint origin, CGSize size) {
    return CGRectMake(origin.x, origin.y, size.width, size.height);
};

// 通过CGRect获取中心点CGPoint
static __inline__ CGPoint CGRectCenter(CGRect rect) { return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)); };

// CGRect添加宽度
static __inline__ CGRect CGRectAddWidth(CGRect rect, CGFloat width) {
    rect.size.width += width;
    return rect;
};

// CGRect添加高度
static __inline__ CGRect CGRectAddHeigth(CGRect rect, CGFloat height) {
    rect.size.height += height;
    return rect;
};

// CGRect添加x值
static __inline__ CGRect CGRectAddLeft(CGRect rect, CGFloat left) {
    rect.origin.x += left;
    return rect;
};

// CGRect添加y值
static __inline__ CGRect CGRectAddTop(CGRect rect, CGFloat top) {
    rect.origin.y += top;
    return rect;
};