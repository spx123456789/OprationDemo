//
//  NSObject+RunTime.h
//  alertController
//
//  Created by fengwenjie on 16/8/1.
//  Copyright © 2016年 fengwenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>

@interface NSObject (RunTime)

/** 获取类的私有属性 */
- (void)getObjcPrivatePropretyWithClass:(Class)className;

/** 获取类的私有方法 */
- (void)getObjcPrivateMethodWithClass:(Class)className;

@end
