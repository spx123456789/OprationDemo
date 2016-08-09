//
//  SXAccount.m
//  OPrationDemo
//
//  Created by SHANPX on 16/7/29.
//  Copyright © 2016年 SHANPX. All rights reserved.
//

#import "SXAccount.h"

@implementation SXAccount
NSCondition *cond;
BOOL  flag;

-(id)init
{
    self=[super init];
    if(self){
        cond=[[NSCondition alloc]init];
    }
    return self;
}
-(id)initWithAccountNo:(NSString *)aAccount balance:(CGFloat)aBalance
{
    self=[super init];
    if (self) {
        cond=[[NSCondition alloc]init];
        _accountNo=aAccount;
        _balance=aBalance;
    }
    return self;
}
-(void)draw:(CGFloat)drawAmount
{
    [cond lock];
    
    if (!flag) {
        [cond wait];
    }else{
        NSLog(@"%@取钱:%g",[NSThread currentThread].name,drawAmount);
        _balance-=drawAmount;
        NSLog(@"账户余额为:%g",_balance);
        flag=!(_balance<800);
        [cond broadcast];
    }
    [cond unlock];
}

-(void)deposit:(CGFloat)depositAmount
{
    [cond lock];
    if (flag) {
        [cond wait];// [cond waitUntilDate:<#(nonnull NSDate *)#>]
    }else{
        NSLog(@"%@存钱:%g",[NSThread currentThread].name,depositAmount);
        _balance+=depositAmount;
        NSLog(@"账户余额为:%g",_balance);
        flag=_balance>=800;
        [cond broadcast];
    }
    [cond unlock];
}

@end
