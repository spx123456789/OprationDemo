//
//  NSObject+Common.m
//  Imora
//
//  Created by wangyuehong on 15/9/12.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "NSObject+Common.h"

@implementation NSObject (ora_Common)

- (NSString *)tipFromError:(NSError *)error {
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"msg"]) {
            NSArray *msgArray = [[error.userInfo objectForKey:@"msg"] allValues];
            NSUInteger num = [msgArray count];
            for (int i = 0; i < num; i++) {
                NSString *msgStr = [msgArray objectAtIndex:i];
                if (i + 1 < num) {
                    [tipStr appendString:[NSString stringWithFormat:@"%@\n", msgStr]];
                } else {
                    [tipStr appendString:msgStr];
                }
            }
        } else {
            if (error.code == -1009) {
                tipStr = [NSMutableString stringWithString: @"没有网络"];
            }
            else
            {
                if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                    tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                } else {
                    [tipStr appendFormat:@"ErrorCode%ld", (long)error.code];
                }
            }
            
        }
        return tipStr;
    }
    return nil;
}
- (BOOL)showError:(NSError *)error {
    NSString *tipStr = [self tipFromError:error];
    [self showHudTipStr:tipStr];
    return YES;
}

- (void)showHudTipStr:(NSString *)tipStr {
    if (tipStr && tipStr.length > 0) {
    }
}
#pragma mark  返回任意对象的字符串式的内存地址
-(NSString *)address{
    return [NSString stringWithFormat:@"%p",self];
}




#pragma mark  调用方法
-(void)callSelectorWithSelString:(NSString *)selString paramObj:(id)paramObj{
    
    //转换为sel
    SEL sel=NSSelectorFromString(selString);
    
    if(![self respondsToSelector:sel]) return;
    
    //调用
    //    objc_msgSend(self, sel);
    
}

@end
