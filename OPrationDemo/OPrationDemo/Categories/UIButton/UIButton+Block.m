//
//  UIButton+Block.m
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "UIButton+Block.h"
#import "NSObject+associatedObject.h"

@implementation UIButton (ora_Block)

- (void)ora_handleClickBlock:(OraButtonActionBlock)action {
    [self ora_handleControlEvents:UIControlEventTouchUpInside withBlock:action];
}

- (void)ora_handleControlEvents:(UIControlEvents)events withBlock:(OraButtonActionBlock)action {
    [self ora_setAssociateCopyValue:action withKey:@selector(ora_handleControlEvents:withBlock:)];
    [self addTarget:self action:@selector(ora_buttonAction:) forControlEvents:events];
}

- (void)ora_buttonAction:(id)sender {
    OraButtonActionBlock block =
        (OraButtonActionBlock)[self ora_associatedValueForKey:@selector(ora_handleControlEvents:withBlock:)];
    if (block) {
        self.enabled = NO;
        block();
        self.enabled = YES;
    }
}

@end
