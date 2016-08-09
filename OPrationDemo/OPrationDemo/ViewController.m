//
//  ViewController.m
//  OPrationDemo
//
//  Created by SHANPX on 16/8/2.
//  Copyright © 2016年 SHANPX. All rights reserved.
//

#import "ViewController.h"
#import "ESPThread.h"
#import "SXThread.h"
#import "SXOpration.h"
#import "SXAccount.h"
@interface ViewController ()
@property(nonatomic, assign) NSInteger count;
@property(nonatomic, strong) ESPThread *thread;
@property (nonatomic,assign) NSInteger ticketCount;
@property (nonatomic,strong) NSThread *newthread;
@property (nonatomic,strong) SXAccount *account;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadExitNotice) name:NSThreadWillExitNotification object:nil];

    _count = 0;
    _ticketCount=10;

//    [self doNSThread];
    
    
//    [self doGCD];
    [self doNSOpration];
    ////  self.thread = [ESPThread currentThread];

//  dispatch_async(dispatch_get_main_queue(), ^{
//    [self.thread sleep:100000];
//  });
//    
//    
//    
//    
//    
//
    
  }

-(void)doNSOpration
{
    /*
     NSOperation 是苹果公司对 GCD 的封装，完全面向对象，所以使用起来更好理解。 大家可以看到 NSOperation 和 NSOperationQueue 分别对应 GCD 的 任务 和 队列 。操作步骤也很好理解：
     
     将要执行的任务封装到一个 NSOperation 对象中。
     将此任务添加到一个 NSOperationQueue 对象中。
     
     那么如何添加任务呢？
     值得说明的是，NSOperation 只是一个抽象类，所以不能封装任务。但它有 2 个子类用于封装任务。分别是：NSInvocationOperation 和 NSBlockOperation 。创建一个 Operation 后，需要调用 start 方法来启动任务，它会 默认在当前队列同步执行。当然你也可以在中途取消一个任务，只需要调用其 cancel 方法即可。
     */
    
    
    //1.创建NSInvocationOperation对象
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
//    
//    //2.开始执行
//    [operation start];
  
    
    
    
//    //1.创建NSBlockOperation对象
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    
//    //2.开始任务
//    [operation start];
    
    //1.创建NSBlockOperation对象
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    
//    //添加多个Block
//    for (NSInteger i = 0; i < 5; i++) {
//        [operation addExecutionBlock:^{
//            NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
//        }];
//    }
//    
//    //2.开始任务
//    [operation start];
    
   //创建一个主队列
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    //1.创建一个其他队列
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    
//    //2.创建NSBlockOperation对象
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    
//    //3.添加多个Block 注意：addExecutionBlock 方法必须在 start() 方法之前执行，否则就会报错：
//    for (NSInteger i = 0; i < 5; i++) {
//        [operation addExecutionBlock:^{
//            NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
//        }];
//    }
//    
    //4.队列添加任务
//    [queue addOperation:operation];
    
    //现在问题来了，如果我们需要串行队列咋办捏？
        //1.创建一个其他队列
//        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//        queue.maxConcurrentOperationCount=1;
//
//        [queue addOperationWithBlock:^{
//        NSLog(@"addOperationWithBlock%@", [NSThread currentThread]);
//
//        }];
//    
//        //2.创建NSBlockOperation对象
//        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//            NSLog(@"%@", [NSThread currentThread]);
//        }];
////
//        //3.添加多个Block 注意：addExecutionBlock 方法必须在 start() 方法之前执行，否则就会报错：
//        for (NSInteger i = 0; i < 5; i++) {
//            [operation addExecutionBlock:^{
//                NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
//            }];
//        }
//    
//        //4.队列添加任务
//        [queue addOperation:operation];
//
//    SXOpration  *opration=[[SXOpration alloc]init];
//    [queue addOperation:opration];

   // NSOperation 有一个非常实用的功能，那就是添加依赖。比如有 3 个任务：A: 从服务器上下载一张图片，B：给这张图片加个水印，C：把图片返回给服务器。这时就可以用到依赖了:
//    //1.任务一：下载图片
//    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"下载图片 - %@", [NSThread currentThread]);
//        [NSThread sleepForTimeInterval:1.0];
//    }];
//    
//    //2.任务二：打水印
//    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"打水印   - %@", [NSThread currentThread]);
//        [NSThread sleepForTimeInterval:1.0];
//    }];
//    
//    //3.任务三：上传图片
//    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"上传图片 - %@", [NSThread currentThread]);
//        [NSThread sleepForTimeInterval:1.0];
//    }];
//    
//    //4.设置依赖
//    [operation2 addDependency:operation1];      //任务二依赖任务一
//    [operation3 addDependency:operation2];      //任务三依赖任务二
//    
//    //5.创建队列并加入任务
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperations:@[operation3, operation2, operation1] waitUntilFinished:NO];
    
   /*
    
    NSOperation
    
    BOOL executing; //判断任务是否正在执行
    
    BOOL finished; //判断任务是否完成
    
    void (^completionBlock)(void); //用来设置完成后需要执行的操作
    
    - (void)cancel; //取消任务
    
    - (void)waitUntilFinished; //阻塞当前线程直到此任务执行完毕
    
    
    NSOperationQueue
    
    NSUInteger operationCount; //获取队列的任务数
    
    - (void)cancelAllOperations; //取消队列中所有的任务
    
    - (void)waitUntilAllOperationsAreFinished; //阻塞当前线程直到此队列中的所有任务执行完毕
    
    [queue setSuspended:YES]; // 暂停queue
    
    [queue setSuspended:NO]; // 继续queue
    */
   
    
    
    
}

-(void)doGCD{
    /*
    一、简单介绍
    
    1.什么是GCD？
    
    全称是Grand Central Dispatch，可译为“牛逼的中枢调度器”
    
    纯C语言，提供了非常多强大的函数
    
    
    
    2.GCD的优势
    
    GCD是苹果公司为多核的并行运算提出的解决方案
    
    GCD会自动利用更多的CPU内核（比如双核、四核）
    
    GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）
    
    程序员只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码
    
    
    
    3.提示:
     (1)GCD存在于libdispatch.dylib这个库中，这个调度库包含了GCD的所有的东西，但任何IOS程序，默认就加载了这个库，在程序运行的过程中会动态的加载这个库，不需要我们手动导入。
     (2)GCD是纯C语言的，因此我们在编写GCD相关代码的时候，面对的函数，而不是方法。
     (3)GCD中的函数大多数都以dispatch开头。
     
     二、任务和队列
     
     GCD中有2个核心概念
     
     （1）任务：执行什么操作
     
     （2）队列：用来存放任务
     
     
     
     GCD的使用就2个步骤
     
     （1）定制任务
     
     （2）确定想做的事情
     
     
     
     将任务添加到队列中，GCD会自动将队列中的任务取出，放到对应的线程中执行
     
     提示：任务的取出遵循队列的FIFO原则：先进先出，后进后出
     */
   // DISPATCH_QUEUE_CONCURRENT(并行队列) 和DISPATCH_QUEUE_SERIAL（串行队列）
    //创建一个串行队列
    dispatch_queue_t dispatch_serial =
          dispatch_queue_create("dispatch_serial", DISPATCH_QUEUE_SERIAL);
    
    
    dispatch_queue_t dispatch_serial2 =dispatch_get_main_queue();
    /*
     在这边给大家区别一下sync  和async
     sync   调用的队列不管是并发队列，手动创建的串行队列还是主队列，都没有开启新的线程，而且都是串行执行任务
     
     async  调用的队列 功能正常（即串行队列串行执行，并发队列并行执行） 主线程还是串行执行
     
     */
    
//    dispatch_apply(5, dispatch_serial, ^(size_t time) {
//        //time 表示正在执行第几个
//        NSLog(@"---------%@-------%lu", [NSThread currentThread],time);
//
//    });
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"dispatch_once---------%@-------", [NSThread currentThread]);
//        
//    });
    
      dispatch_async(dispatch_serial, ^{
        NSLog(@"---------%@-------", [NSThread currentThread]);
          
      });

    //创建一个并行队列
    dispatch_queue_t dispatch_concurrent=dispatch_queue_create("dispatch_concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(dispatch_concurrent, ^{
        NSLog(@"---------%@-------", [NSThread currentThread]);
        
    });
    
 /*
#define DISPATCH_QUEUE_PRIORITY_HIGH 2 // 高
    
#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0 // 默认（中）
    
#define DISPATCH_QUEUE_PRIORITY_LOW (-2) // 低
    
#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN // 后台
  */
    
    dispatch_queue_t dispatch_concurrent2=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatch_concurrent2, ^{
            NSLog(@"----%@",[NSThread currentThread]);
        });
    dispatch_async(dispatch_concurrent2, ^{
                NSLog(@"----%@",[NSThread currentThread]);
            });
    dispatch_async(dispatch_concurrent2, ^{
                 NSLog(@"----%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    
}


#pragma mark -  NSThread简介

-(void)doNSThread
{
    /*
     
     一、什么是NSThread
     
     NSThread是基于线程使用，轻量级的多线程编程方法（相对GCD和NSOperation），一个NSThread对象代表一个线程，需要手动管理线程的生命周期，处理线程同步等问题。
     
     二、NSThread方法介绍
//     */
//        for (int i = 0; i < 1; i++) {
//            //动态创建
//    
//            NSThread *thread = [[NSThread alloc] initWithTarget:self
//                                                       selector:@selector(printString:)
//                                                        object:@"initWithTarget"];
//            NSThread *thread2 = [[NSThread alloc] initWithTarget:self
//                                                       selector:@selector(printString:)
//                                                         object:@"initWithTarget2"];
//            /*
//             NSQualityOfServiceUserInteractive：最高优先级，用于用户交互事件
//             NSQualityOfServiceUserInitiated：次高优先级，用于用户需要马上执行的事件
//             NSQualityOfServiceDefault：默认优先级，主线程和没有设置优先级的线程都默认为这个优先级
//             NSQualityOfServiceUtility：普通优先级，用于普通任务
//             NSQualityOfServiceBackground：最低优先级，用于不重要的任务
//             */
//    
//            //优先级
//    
//            [thread setQualityOfService:NSQualityOfServiceDefault];
//            [thread2 setQualityOfService:NSQualityOfServiceUserInteractive];
//    
//            //线程开启
//            [thread start];
//            [thread2 start];
//            //线程取消 ， 取消线程并不会马上停止并退出线程，仅仅只作（线程是否需要退出）状态记录
//    //        [thread cancel];
//            //停止方法会立即终止除主线程以外所有线程（无论是否在执行任务）并退出，需要在掌控所有线程状态的情况下调用此方法，否则可能会导致内存问题。慎用哦。
//    //        [NSThread exit];
//            //静态创建
//            [NSThread detachNewThreadSelector:@selector(printString:)
//                                     toTarget:self
//                                   withObject:@"detachNewThreadSelector"];
//        }
    //
    //
    //
    //
    //     //在指定线程中执行，但该线程必须具备run loop。？？？？？
  //  NSLog(@"--%@--", [NSThread currentThread]);
//        NSThread *thread = [[NSThread alloc] initWithTarget:self
//                                               selector:@selector(printString:)
//                                                 object:@"initWithTarget"];
//        [thread start];
//        [self performSelector:@selector(printString:) onThread:thread withObject:@"performSelectoronThread" waitUntilDone:NO];
//     NSLog(@"wwwwwwwww%@", [NSThread currentThread]);

    
    //
    //
         //隐含产生新线程，调用该方法的效果和你在当前对象里面使用 NSThread 的 detachNewThreadSelector:toTarget:withObject:传递 selectore,object 作为参数 的方法一样。新的线程将会被立即生成并运行,它使用默认的设置。
//        [self performSelectorInBackground:@selector(printString:) withObject:@"performSelectorInBackground"];
    //
    //    //在主线程中运行方法，wait表示是否阻塞这个方法的调用，如果为YES则等待主线程中运行方法结束,经过测试，为YES时马上执行，为NO时先加入主线程的runloop事件循环里面，等待runloop来调度执行。一般可用于在子线程中调用UI方法。
    
    //
      //  [self performSelectorOnMainThread:@selector(printString:) withObject:@"performSelectorOnMainThread" waitUntilDone:NO];
    
    
    // 四、线程同步
    
    // 线程和其他线程可能会共享一些资源，当多个线程同时读写同一份共享资源的时候，可能会引起冲突。线程同步是指是指在一定的时间内只允许某一个线程访问某个资源
    
    //iOS实现线程加锁有NSLock和@synchronized两种方式。
    
//    _account=[[SXAccount alloc]initWithAccountNo:@"321321" balance:1000];
//    
//    [NSThread detachNewThreadSelector:@selector(darwMethod:) toTarget:self withObject:[NSNumber numberWithDouble:800.00]];
//    
//    [NSThread detachNewThreadSelector:@selector(deposititMethod:) toTarget:self withObject:[NSNumber numberWithDouble:800.00]];
//    [NSThread detachNewThreadSelector:@selector(darwMethod:) toTarget:self withObject:[NSNumber numberWithDouble:800.00]];
//    
//    [NSThread detachNewThreadSelector:@selector(deposititMethod:) toTarget:self withObject:[NSNumber numberWithDouble:800.00]];
//
    //demo示例
//        NSThread * window1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
//    
//        window1.name = @"北京售票窗口";
//    
//        [window1 start];
//    
//        NSThread * window2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
//    
//        window2.name = @"广州售票窗口";
//    
//        [window2 start];
    
    
    //线程启动后，执行saleTicket，执行完毕后就会退出，为了模拟持续售票的过程，我们需要给它加一个循环
    
//        NSThread * window1 = [[NSThread alloc]initWithTarget:self selector:@selector(thread1) object:nil];
//    
//        [window1 start];
//    
//        NSThread * window2 = [[NSThread alloc]initWithTarget:self selector:@selector(thread2) object:nil];
//    
//        [window2 start];
//    
//        [self performSelector:@selector(saleTicket) onThread:window1 withObject:nil waitUntilDone:NO];
//    
//        [self performSelector:@selector(saleTicket) onThread:window2 withObject:nil waitUntilDone:NO];
    
//    //自定义对象
//    SXThread  *sxthread=[[SXThread alloc]init];
//    
//    [sxthread start];
    /*一些常用的方法
     + (NSThread *)currentThread; //获得当前线程
     
     2. + (void)sleepForTimeInterval:(NSTimeInterval)ti; //线程休眠
     
     3. + (NSThread *)mainThread; //主线程，亦即UI线程了
     
     4. - (BOOL)isMainThread; + (BOOL)isMainThread; //当前线程是否主线程
     
     5. - (BOOL)isExecuting; //线程是否正在运行
     
     6. - (BOOL)isFinished; //线程是否已结束
     */
    
    //创建一个常驻的线程，不建议使用
//  NSThread  *newthread = [[NSThread alloc] initWithTarget:self
//                                         selector:@selector(newThread)
//                                           object:@"测试"];
//    [newthread start];
//    [self performSelector:@selector(saleTicket) onThread:newthread withObject:@"111111" waitUntilDone:NO];
    
    
}

//线程退出函数，系统级的
-(void)threadExitNotice
{
    NSLog(@"本线程退出————————————%@",[NSThread currentThread]);

}
/**
 *  卖票示例
 */
- (void)saleTicket {
    
    while (1) {
        
        //如果还有票，继续售卖
        @synchronized (self) {
            if (_ticketCount > 0) {
                
                _ticketCount --;
                
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", _ticketCount, [NSThread currentThread].name]);
                
                [NSThread sleepForTimeInterval:0.2];
                
            }
            
            //如果已卖完，关闭售票窗口
            
            else {
                
                break;
                
            }
        }
        
        
    }
    
}

- (void)thread1 {
    
    [NSThread currentThread].name = @"北京售票窗口";
    
    NSRunLoop * runLoop1 = [NSRunLoop currentRunLoop];
    
    [runLoop1 runUntilDate:[NSDate date]]; //一直运行
    
}

- (void)thread2 {
    
    [NSThread currentThread].name = @"广州售票窗口";
    
    NSRunLoop * runLoop2 = [NSRunLoop currentRunLoop];
    
    [runLoop2 runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]]; //自定义运行时间
    
}


- (void)newThread {
  @autoreleasepool {
    
      [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];

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
    [[NSRunLoop currentRunLoop]run];
    
//    NSLog(@"--%@---%@", [NSThread currentThread], str);
    for (int i = 0; i < 10; i++) {
        if ([NSThread currentThread].isCancelled) {
            [NSThread exit];
        }
        
      NSLog(@"%@---%@--%d", str, [NSThread currentThread], i);
    }
    [self performSelectorOnMainThread:@selector(printmainString:)
                           withObject:str
                        waitUntilDone:YES];
}
- (void)printmainString:(NSString *)str {
  NSLog(@"---------%@-------%@", [NSThread currentThread], str);
}

-(void)deposititMethod:(NSNumber*)depositAmount
{
    [NSThread currentThread].name=@"乙";
    for (int i=0; i<100; i++) {
        [_account deposit:depositAmount.doubleValue];
    }

}
-(void)darwMethod:(NSNumber*)drawAmount
{
    [NSThread currentThread].name=@"甲";
    for (int i=0; i<100; i++) {
        [_account draw:drawAmount.doubleValue];
    }

    
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
