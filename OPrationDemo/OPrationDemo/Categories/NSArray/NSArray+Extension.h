//
//  NSArray+Extension.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (ora_Kit)

// 替代objectAtIndex
// 经过安全判断不会引起Crash  如果index出界,则返回nil
- (id)ora_objectAtIndex:(NSUInteger)index;

// 数组去重
- (instancetype)ora_arrayByAddUniqueArray:(NSArray *)array;

// 数组是否为空
- (BOOL)ora_isEmpty;

// 反转数组
- (NSArray *)ora_reverse;
/**
 *  数组转字符串
 */
-(NSString *)string;


/**
 *  数组比较
 */
-(BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array;


/**
 *  数组计算交集
 */
-(NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

/**
 *  数据计算差集
 */
-(NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray;
@end
