//
//  SXAccount.h
//  OPrationDemo
//
//  Created by SHANPX on 16/7/29.
//  Copyright © 2016年 SHANPX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SXAccount : NSObject
@property (nonatomic,assign) CGFloat balance;
@property (nonatomic,copy) NSString *accountNo;
-(id)initWithAccountNo:(NSString *)aAccount balance:(CGFloat)aBalance;

-(void)draw:(CGFloat)drawAmount;

-(void)deposit:(CGFloat)depositAmount;

@end
