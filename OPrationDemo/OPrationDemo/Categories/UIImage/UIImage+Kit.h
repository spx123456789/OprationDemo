//
//  UIImage+Kit.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ora_Kit)

/**
 *  图片上添加文字
 *
 *  @param text 要添加的文字
 *  @param rect 区域大小
 *
 *  @return 添加文字后的图片
 */
- (UIImage *)ora_drawText:(NSString *)text inRect:(CGRect)rect;

/**
 *  图片上添加文字
 *
 *  @param text 要添加的文字
 *  @param font 字体大小
 *  @param rect 区域大小
 *
 *  @return 添加文字后的图片
 */
- (UIImage *)ora_drawText:(NSString *)text font:(UIFont *)font inRect:(CGRect)rect;

/**
 *  @brief  将本图像以一定压缩质量转换成data。  如果能转换成JPEG格式，则会转换成JPEG；否则会被转换成PNG格式的data
 *
 *  @param quality 压缩质量。详见UIImageJPEGRepresentation
 *
 *  @return 如果能转换成data，则返回data。否则返回nil。
 */
- (NSData *)ora_dataWithCompressionQuality:(CGFloat)quality;

/**
 *  调整图片大小
 *
 *  @param size 要调整的尺寸
 *
 *  @return 调整后的图片
 */
- (UIImage *)ora_resetImageSize:(CGSize)size;

- (UIImage *)ora_croppedImage:(CGRect)cropRect;

-(UIImage*)ora_rotate:(UIImageOrientation)orient;


@end
