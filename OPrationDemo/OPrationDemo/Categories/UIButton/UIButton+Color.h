//
//  UIButton+Color.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  使用颜色为Button生成背景图
 */
@interface UIButton (ora_Color)

/**
 * 用颜色为button生成背景图
 */
- (UIImage *)ora_setBackgroundImageWithColor:(UIColor *)color forState:(UIControlState)state;

/**
 *  用颜色为button生成图标   size为图标大小
 */
- (UIImage *)ora_setImageWithColor:(UIColor *)color forState:(UIControlState)state size:(CGSize)size;

@end
