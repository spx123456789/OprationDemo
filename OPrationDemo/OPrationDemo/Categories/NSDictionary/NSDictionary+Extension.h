//
//  NSDictionary+Extension.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (ora_Short)

- (long)ora_longForKey:(NSString *)key;

- (int)ora_intForKey:(NSString *)key;

- (NSString *)ora_stringForKey:(id)key;

- (NSNumber *)ora_numberForKey:(id)key;

- (NSArray *)ora_arrayForKey:(id)key;

- (NSDictionary *)ora_dictionaryForKey:(id)key;

- (NSInteger)ora_integerForKey:(id)key;

- (NSUInteger)ora_unsignedIntegerForKey:(id)key;

- (BOOL)ora_boolForKey:(id)key;

- (int16_t)ora_int16ForKey:(id)key;

- (int32_t)ora_int32ForKey:(id)key;

- (int64_t)ora_int64ForKey:(id)key;

- (char)ora_charForKey:(id)key;

- (short)ora_shortForKey:(id)key;

- (float)ora_floatForKey:(id)key;

- (double)ora_doubleForKey:(id)key;

- (long long)ora_longLongForKey:(id)key;

- (unsigned long long)ora_unsignedLongLongForKey:(id)key;

// CG
- (CGFloat)ora_CGFloatForKey:(id)key;

- (CGPoint)ora_pointForKey:(id)key;

- (CGSize)ora_sizeForKey:(id)key;

- (CGRect)ora_rectForKey:(id)key;

// 根据key/key形式获取数据，分隔符'/'
- (id)getObjectByPath:(NSString *)path;
@end
