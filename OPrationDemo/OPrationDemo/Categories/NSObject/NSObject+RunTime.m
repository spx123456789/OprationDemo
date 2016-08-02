//
//  NSObject+RunTime.m
//  alertController
//
//  Created by fengwenjie on 16/8/1.
//  Copyright © 2016年 fengwenjie. All rights reserved.
//

#import "NSObject+RunTime.h"

@implementation NSObject (RunTime)

- (void)getObjcPrivatePropretyWithClass:(Class)className
{
    unsigned int count = 0;
    // 定义对象的实例变量，包括类型和名字
    Ivar *members = class_copyIvarList(className, &count);
    for (int i = 0; i < count; i++) {
        Ivar var = members[i];
        // 获取名字 使用时不需要下划线
        const char *menAddress = ivar_getName(var);
        // 获取类型：B为bool q为枚举 @？为block
        const char *menType = ivar_getTypeEncoding(var);
        NSLog(@"menAddress: %s----menType: %s", menAddress, menType);
    }
    
    
    // 如果要修改某个私有属性可以使用KVC或者runtime，下面是使用runtime的举例
    /**
     *  @param class     如：UIAlertAction *action = [[UIAlertAction alloc] init];
     *  @param m_address 类的属性名称
     *  @param @"aa"     给属性对应的类型赋值，这里举例是字符串
     */
//    Ivar m_address = members[0];
//    object_setIvar(action, m_address, @"aa");
    
}

- (void)getObjcPrivateMethodWithClass:(Class)className
{
    unsigned int count = 0;
    Method *memberFuncs = class_copyMethodList(className, &count);
    for (int i = 0; i < count; i++)
    {
        SEL m_address = method_getName(memberFuncs[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(m_address) encoding:NSUTF8StringEncoding];
        NSLog(@"member method: %@",methodName);
    }
}


@end
