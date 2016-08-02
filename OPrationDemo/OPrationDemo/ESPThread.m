//
//  ESPThread.m
//  OPrationDemo
//
//  Created by SHANPX on 16/8/1.
//  Copyright © 2016年 SHANPX. All rights reserved.
//

#import "ESPThread.h"

@interface ESPThread()

@property(atomic, assign, getter=isInterrupt) BOOL isInterrupt;
@property(atomic, strong) NSCondition *condition;

@end

@implementation ESPThread

+ (ESPThread *) currentThread
{
    return [[ESPThread alloc]init];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.isInterrupt = NO;
        self.condition = [[NSCondition alloc]init];
    }
    return self;
}

- (BOOL) sleep: (long long) milliseconds
{
    [self.condition lock];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: milliseconds/1000.0];
    BOOL signaled = NO;
    while (!self.isInterrupt && (signaled = [self.condition waitUntilDate:date]))
    {
    }
    [self.condition unlock];
    return self.isInterrupt;
}

- (void) interrupt
{
    [self.condition lock];
    self.isInterrupt = YES;
    [self.condition signal];
    [self.condition unlock];
}

@end