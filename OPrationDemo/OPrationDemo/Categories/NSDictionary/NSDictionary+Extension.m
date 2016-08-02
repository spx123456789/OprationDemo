//
//  NSDictionary+Extension.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (ora_Short)

- (long)ora_longForKey:(NSString *)key {
    id object = [self objectForKey:key];

    if ([object isKindOfClass:[NSNumber class]]) {
        return [object longValue];
    }

    if ([object isKindOfClass:[NSString class]]) {
        return (long)[((NSString *)object)longLongValue];
    }

    return 0;
}

- (int)ora_intForKey:(NSString *)key {
    id object = [self objectForKey:key];

    if ([object isKindOfClass:[NSNumber class]]) {
        return [object intValue];
    }

    if ([object isKindOfClass:[NSString class]]) {
        return [((NSString *)object)intValue];
    }

    return 0;
}

- (NSString *)ora_stringForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }

    return nil;
}

- (NSNumber *)ora_numberForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString *)value];
    }
    return nil;
}

- (NSArray *)ora_arrayForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)ora_dictionaryForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSInteger)ora_integerForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)ora_unsignedIntegerForKey:(id)key {
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)ora_boolForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)ora_int16ForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)ora_int32ForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)ora_int64ForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)ora_charForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    return 0;
}

- (short)ora_shortForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

- (float)ora_floatForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

- (double)ora_doubleForKey:(id)key {
    id value = [self objectForKey:key];

    if (value == nil || value == [NSNull null]) {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (long long)ora_longLongForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)ora_unsignedLongLongForKey:(id)key {
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

// CG
- (CGFloat)ora_CGFloatForKey:(id)key {
    CGFloat f = [self[key] doubleValue];
    return f;
}

- (CGPoint)ora_pointForKey:(id)key {
    CGPoint point = CGPointFromString(self[key]);
    return point;
}

- (CGSize)ora_sizeForKey:(id)key {
    CGSize size = CGSizeFromString(self[key]);
    return size;
}

- (CGRect)ora_rectForKey:(id)key {
    CGRect rect = CGRectFromString(self[key]);
    return rect;
}

- (id)getObjectByPath:(NSString *)path {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    id data = nil;

    //参数检查
    if (path) {
        NSArray *list = [path componentsSeparatedByString:@"/"];
        id node = self;
        for (NSString *name in list) {
            if (![node isKindOfClass:[NSDictionary class]]) {
                node = nil;
                break;
            }

            node = [node objectForKey:name];
            if (!node || [[node class] isSubclassOfClass:[NSNull class]]) {
                //没有找到
                node = nil;
                break;
            }

            if ([node isKindOfClass:[NSString class]] && [node isEqualToString:@"(null)"]) {
                //没有找到
                node = nil;
                break;
            }
            if (![node isKindOfClass:[NSDictionary class]]) {
                break;
            }
        }

        data = node;
    }
    return data;
}

@end
