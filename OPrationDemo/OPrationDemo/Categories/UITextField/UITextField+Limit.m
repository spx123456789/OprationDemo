//
//  UITextField+Limit.m
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextField+Limit.h"

@implementation UITextField (ora_Limit)

static void *limitMaxLengthKey = &limitMaxLengthKey;

- (void)setOra_maxLength:(NSUInteger)maxLength {
    objc_setAssociatedObject(self, limitMaxLengthKey, @(maxLength), OBJC_ASSOCIATION_COPY);

    //监控自身文本变化
    if (maxLength > 0) {
        [self addTarget:self action:@selector(__valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    } else {
        [self removeTarget:self action:@selector(__valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    }
}

- (NSUInteger)ora_maxLength {
    return [objc_getAssociatedObject(self, limitMaxLengthKey) unsignedIntegerValue];
}

#pragma mark - private

- (void)__valueChanged:(UITextField *)textField {
    //文本变化后判断文本长度是否符合要求
    if (self.ora_maxLength == 0) {
        return;
    }

    if ([textField.text length] <= self.ora_maxLength) {
        return;
    }

    NSString *subString = [textField.text substringToIndex:self.ora_maxLength];
    dispatch_async(dispatch_get_main_queue(), ^{
      textField.text = subString;
      [textField sendActionsForControlEvents:UIControlEventEditingChanged];
    });
}

@end
