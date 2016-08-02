//
//  UIButton+Block.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OraButtonActionBlock)();

@interface UIButton (ora_Block)

/**
 *  @brief  给按钮加上click事件
 *
 *  @param action 当按钮click时要执行的block。
 */
- (void)ora_handleClickBlock:(OraButtonActionBlock)action;

/**
 *  @brief 给按钮加上block事件
 *
 *  @param events 要响应的事件
 *  @param action 当events触发时，要执行的block
 */
- (void)ora_handleControlEvents:(UIControlEvents)events withBlock:(OraButtonActionBlock)action;

@end
