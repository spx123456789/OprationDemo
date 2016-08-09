//
//  SXThread.m
//  OPrationDemo
//
//  Created by SHANPX on 16/8/8.
//  Copyright © 2016年 SHANPX. All rights reserved.
//

#import "SXThread.h"

@implementation SXThread
//- (void)main NS_AVAILABLE(10_5, 2_0);	// thread body method
//{
//    //线程暂停NSThread的暂停会有阻塞当前线程的效果
//    
//    [NSThread sleepForTimeInterval:1.0];//　（以暂停一秒为例）
//    
//    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]]; //暂停到指定时间
//
//}
- (void)main

{
    
    // thread init
    
    if (![[NSThread currentThread] isCancelled])
        
    {
        NSLog(@"SXThread.h  -------");
        // thread loop
        
       // [NSThread sleepForTimeInterval:1.0]; //等同于sleep(1);
        
    }
    
    // release resources of thread
    
}

@end
