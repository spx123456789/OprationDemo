//
//  UIImage+Color.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ora_Color)

// 根据UIColor生成1像素的图片
+ (UIImage *)ora_imageWithColor:(UIColor *)color;

// 根据UIColor及size指定大小生成图片
+ (UIImage *)ora_imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;
@end
