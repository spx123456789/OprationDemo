//
//  UILabel+ora_Kit.m
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "UILabel+Extension.h"
#import "NSString+Extension.h"

@implementation UILabel (ora_Size)

- (CGSize)ora_sizeWithText:(NSString *)text {
    return [text ora_sizeWithFont:self.font];
}

- (CGSize)ora_sizeForOwnerText {
    return [self.text ora_sizeWithFont:self.font];
}

- (CGFloat)ora_heightWithMaxWidth:(CGFloat)maxWidth text:(NSString *)text {
    return [text ora_heightWithWidth:maxWidth font:self.font];
}

- (CGFloat)ora_heightWithMaxWidth:(CGFloat)maxWidth {
    return [self.text ora_heightWithWidth:maxWidth font:self.font];
}

@end
