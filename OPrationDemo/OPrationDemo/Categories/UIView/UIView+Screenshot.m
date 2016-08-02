//
//  UIView+Screenshot.m
//
//  Created by wangyuehong on 15/9/7.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "UIView+Screenshot.h"

@implementation UIView (ora_Screenshot)

- (UIImage *)ora_screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
