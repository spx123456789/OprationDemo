//
//  UIView+BlockGesture.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (ora_BlockGesture)

//添加点击事件
- (void)ora_addTapActionWithBlock:(GestureActionBlock)block;

//移除点击事件
- (void)ora_removeTapAction;

//添加长按事件
- (void)ora_addLongPressActionWithBlock:(GestureActionBlock)block;

//移除长按事件
- (void)ora_removeLongPressAction;

@end
