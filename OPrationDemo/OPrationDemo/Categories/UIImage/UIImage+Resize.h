//
//  UIImage+Resize.h
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-17.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

- (UIImage *)fixOrientation;

- (UIImage *)rotatedByDegrees:(CGFloat)degrees;

/**
 *  拉伸指定名字的图片 一般用来拉伸图片 用作按钮背景
 *
 *  @param name 图片名
 *
 *  @return 拉伸后得图片
 */
+ (UIImage *) resizedImageWithName: (NSString *) name ;
/**
 *  拉伸指定图片 并指定 左右拉伸范围
 *
 *  @param name   图片名
 *  @param left   左边大小
 *  @param height 右边大小
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *) resizedImageWithName: (NSString *) name left:(CGFloat) left height: (CGFloat) height ;


@end
