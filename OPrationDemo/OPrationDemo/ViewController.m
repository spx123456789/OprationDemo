//
//  ViewController.m
//  OPrationDemo
//
//  Created by SHANPX on 16/8/2.
//  Copyright © 2016年 SHANPX. All rights reserved.
//

#import "ViewController.h"
#import "ESPThread.h"
@interface ViewController ()
@property(nonatomic, assign) NSInteger count;
@property(nonatomic, strong) ESPThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _count = 0;

  self.thread = [ESPThread currentThread];
  NSThread *newthread = [[NSThread alloc] initWithTarget:self
                                                selector:@selector(newThread)
                                                  object:@"测试"];
  [newthread start];
    
    
    
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.thread sleep:100000];
  });
    
    
    
    
    
  dispatch_queue_t dispatch =
      dispatch_queue_create("dispatch", DISPATCH_QUEUE_SERIAL);

  dispatch_async(dispatch, ^{
    NSLog(@"---------%@-------", [NSThread currentThread]);

  });

  for (int i = 0; i < 100; i++) {
    NSLog(@"---------%@-------%d", [NSThread currentThread], i);
    NSThread *thread = [[NSThread alloc] initWithTarget:self
                                               selector:@selector(printString:)
                                                 object:@"hello world"];
    [thread start];
    [thread setThreadPriority:1];
      
      
      
    [NSThread detachNewThreadSelector:@selector(printString:)
                             toTarget:self
                           withObject:@"hello world +"];
  }
}
- (void)newThread {
  @autoreleasepool {
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(addtime)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop currentRunLoop] run];
  }
}
- (void)addtime {
  if (_count == 6) {
    NSLog(@"----------------%@", [NSThread currentThread]);
    [self.thread interrupt];
  }
  _count++;
}
- (void)printString:(NSString *)str {
  @synchronized(self) {
    NSLog(@"---------%@-------%@", [NSThread currentThread], str);
    for (int i = 0; i < 100; i++) {
      NSLog(@"%@---------%@-------%d", str, [NSThread currentThread], i);
    }
    [self performSelectorOnMainThread:@selector(printmainString:)
                           withObject:str
                        waitUntilDone:YES];
  }
}
- (void)printmainString:(NSString *)str {
  NSLog(@"---------%@-------%@", [NSThread currentThread], str);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
