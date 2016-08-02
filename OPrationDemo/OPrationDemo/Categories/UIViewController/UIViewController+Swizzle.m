//
//  UIViewController+AOP.m
//
//
//  Created by wangyuehong on 15/9/7.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import <objc/runtime.h>

@implementation UIViewController (ora_Swizzle)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//      Class class = [self class];
//      swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidLoad));
//      swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
//      swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
//      swizzleMethod(class, @selector(viewWillDisappear:), @selector(aop_viewWillDisappear:));
//
//    });
//}
//
//void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
//    Method originalMethod = class_getInstanceMethod(class, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod),
//                                        method_getTypeEncoding(swizzledMethod));
//    if (didAddMethod) {
//        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}
//
//- (void)aop_viewDidAppear:(BOOL)animated {
//    [self aop_viewDidAppear:animated];
//    //添加AOP代码
//}
//
//- (void)aop_viewWillAppear:(BOOL)animated {
//    [self aop_viewWillAppear:animated];
//    //添加AOP代码
//}
//- (void)aop_viewWillDisappear:(BOOL)animated {
//    [self aop_viewWillDisappear:animated];
//    //添加AOP代码
//}
//- (void)aop_viewDidLoad {
//    [self aop_viewDidLoad];
//    //添加AOP代码
//}

@end
