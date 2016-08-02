//
//  UIButton+Color.m
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "UIButton+Color.h"
#import "UIImage+Color.h"

@implementation UIButton (ora_Color)

- (UIImage *)ora_setBackgroundImageWithColor:(UIColor *)color forState:(UIControlState)state {
    UIImage *image = [UIImage ora_imageWithColor:color];
    [self setBackgroundImage:image forState:state];

    return image;
}

- (UIImage *)ora_setImageWithColor:(UIColor *)color forState:(UIControlState)state size:(CGSize)size {
    UIImage *image = [UIImage ora_imageWithColor:color size:size];
    [self setImage:image forState:state];

    return image;
}

@end
