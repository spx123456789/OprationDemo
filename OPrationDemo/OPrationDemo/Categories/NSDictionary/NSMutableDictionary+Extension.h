//
//  NSMutableDictionary+Extension.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (ora_Short)

- (void)ora_setObject:(id)object forKey:(NSString *)key;

- (void)ora_setString:(NSString *)s forKey:(NSString *)key;

- (void)ora_setBool:(BOOL)i forKey:(NSString *)key;

- (void)ora_setInt:(int)i forKey:(NSString *)key;

- (void)ora_setInteger:(NSInteger)i forKey:(NSString *)key;

- (void)ora_setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key;

- (void)ora_setCGFloat:(CGFloat)f forKey:(NSString *)key;

- (void)ora_setChar:(char)c forKey:(NSString *)key;

- (void)ora_setFloat:(float)i forKey:(NSString *)key;

- (void)ora_setDouble:(double)i forKey:(NSString *)key;

- (void)ora_setLongLong:(long long)i forKey:(NSString *)key;

- (void)ora_setPoint:(CGPoint)o forKey:(NSString *)key;

- (void)ora_setSize:(CGSize)o forKey:(NSString *)key;

- (void)ora_setRect:(CGRect)o forKey:(NSString *)key;

@end
