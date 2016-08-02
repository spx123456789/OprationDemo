//
//  NSString+Extension.m
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+Extension.h"

@implementation NSString (ora_Characters)

- (NSString *)ora_pinyinOfName {
    NSMutableString *name = [[NSMutableString alloc] initWithString:self];

    CFRange range = CFRangeMake(0, 1);

    // 汉字转换为拼音,并去除音调
    if (!CFStringTransform((__bridge CFMutableStringRef)name, &range, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef)name, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }

    return name;
}

- (NSString *)ora_firstCharacterOfName {
    NSMutableString *first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];

    CFRange range = CFRangeMake(0, 1);

    // 汉字转换为拼音,并去除音调
    if (!CFStringTransform((__bridge CFMutableStringRef)first, &range, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef)first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }

    NSString *result;
    result = [first substringWithRange:NSMakeRange(0, 1)];

    return result.uppercaseString;
}

- (BOOL)ora_containChinese {
    NSUInteger length = self.length;
    if (0 == length) {
        return NO;
    }
    for (int i = 0; i < length; i++) {
        const char *cstring = [[self substringWithRange:NSMakeRange(i, 1)] UTF8String];
        if (3 == strlen(cstring)) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation NSString (ora_Kit)

- (NSString *)ora_MD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);

    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0],
                                      result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                                      result[8], result[9], result[10], result[11], result[12], result[13], result[14],
                                      result[15]];
}

+ (NSString *)ora_UUID {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);

    CFStringRef uuid_string_ref = CFUUIDCreateString(NULL, uuid_ref);

    CFRelease(uuid_ref);

    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];

    CFRelease(uuid_string_ref);

    return uuid;
}
+ (BOOL)ora_isBlankString:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }

    if (string == NULL) {
        return YES;
    }

    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }

    if ([[string ora_trim] length] == 0) {
        return YES;
    }

    return NO;
}

- (NSString *)ora_trim {
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return result;
}

- (NSString *)ora_trimOnlyWhitespace {
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return result;
}

- (BOOL)ora_isIncludeChinese {
    for (int i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4e00 < ch && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}

- (NSArray *)ora_splitUsingWhitespace {
    NSString *str = [self ora_trimOnlyWhitespace];
    NSArray *array = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    return array;
}

- (BOOL)ora_isVaildPhoneNumber {
    NSString *phoneRegex = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)ora_isVaildQQ {
    NSString *qqRegex = @"^[1-9]\\d{4,9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", qqRegex];
    return [predicate evaluateWithObject:self];
}

@end

@implementation NSString (ora_Size)

- (CGSize)ora_sizeWithFont:(UIFont *)font {
    if ([self length] == 0) {
        return CGSizeZero;
    }

    return [self sizeWithAttributes:@{NSFontAttributeName : font}];
}

- (CGSize)ora_sizeWithLimitSize:(CGSize)size font:(UIFont *)font {
    if ([self length] == 0) {
        return CGSizeZero;
    }

    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{
                                      NSFontAttributeName : font
                                  }
                                     context:nil];
    return rect.size;
}

- (CGFloat)ora_heightWithWidth:(CGFloat)width font:(UIFont *)font {
    return [self ora_sizeWithLimitSize:CGSizeMake(width, MAXFLOAT) font:font].height;
}

@end

@implementation NSString (ora_AutoUTF8Data)

- (NSData *)ora_UTF8Data {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

@end
@implementation NSString (ora_chineseToPinyin)
- (NSString *)pinyin {
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}
@end
