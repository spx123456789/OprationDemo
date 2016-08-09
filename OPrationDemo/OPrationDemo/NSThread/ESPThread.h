//
//  ESPThread.h
//  OPrationDemo
//
//  Created by SHANPX on 16/8/1.
//  Copyright © 2016年 SHANPX. All rights reserved.
//



















#import <Foundation/Foundation.h>

@interface ESPThread : NSObject

+ (ESPThread *) currentThread;

- (BOOL) sleep: (long long) milliseconds;

- (void) interrupt;

- (BOOL) isInterrupt;

@end