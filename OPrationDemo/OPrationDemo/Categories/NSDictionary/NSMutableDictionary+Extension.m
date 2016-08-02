//
//  NSMutableDictionary+Extension.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"

@implementation NSMutableDictionary (ora_Short)

- (void)ora_setObject:(id)object forKey:(NSString *)key {
    if (object) {
        [self setObject:object forKey:key];
    }
}

- (void)ora_setString:(NSString *)s forKey:(NSString *)key {
    if (s) {
        [self setObject:s forKey:key];
    }
}

- (void)ora_setBool:(BOOL)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)ora_setInt:(int)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)ora_setInteger:(NSInteger)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)ora_setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)ora_setCGFloat:(CGFloat)f forKey:(NSString *)key {
    self[key] = @(f);
}

- (void)ora_setChar:(char)c forKey:(NSString *)key {
    self[key] = @(c);
}

- (void)ora_setFloat:(float)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)ora_setDouble:(double)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)ora_setLongLong:(long long)i forKey:(NSString *)key {
    self[key] = @(i);
}

- (void)ora_setPoint:(CGPoint)o forKey:(NSString *)key {
    self[key] = NSStringFromCGPoint(o);
}

- (void)ora_setSize:(CGSize)o forKey:(NSString *)key {
    self[key] = NSStringFromCGSize(o);
}

- (void)ora_setRect:(CGRect)o forKey:(NSString *)key {
    self[key] = NSStringFromCGRect(o);
}

@end
