//
//  NSString+CocoaPlus.m
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import "NSString+.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CocoaPlus)

- (CGSize)sizeWithAttributes:(NSDictionary<NSString *,id> *)attrs fixedWidth:(CGFloat)width {
    if (self == nil) {
        return CGSizeZero;
    }
    
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:attrs
                              context:nil].size;
}

- (CGSize)sizeWithAttributes:(NSDictionary<NSString *,id> *)attrs fixedHeight:(CGFloat)height {
    if (self == nil) {
        return CGSizeZero;
    }
    
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:attrs
                              context:nil].size;
}

- (BOOL)isValidEmail {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPhone {
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isBlankString {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    if ([self length] == 0) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}

- (NSArray<NSValue *> *)rangesOfString:(NSString *)string {
    if (string == nil) {
        return nil;
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *self_copy = [self copy];
    NSRange range = NSMakeRange(0, 0);
    NSUInteger start = 0;
    // 循环找出字符串中重复的内容
    while (1) {
        range = [self_copy rangeOfString:string];
        if (range.location == NSNotFound) {
            break;
        }
        NSValue *value = [NSValue valueWithRange:NSMakeRange(start + range.location, range.length)];
        [array addObject:value];
        
        NSUInteger location = range.location + range.length;
        NSUInteger length = self_copy.length - location;
        if (location + length > self_copy.length) {
            break;
        }
        self_copy = [self_copy substringWithRange:NSMakeRange(location, length)];
        // 记录上一次截取字符串的起始位置
        start += location;
    }
    
    return array;
}

- (NSAttributedString *)attributedStringWithAttributes:(NSDictionary<NSString *, id> *)attributes xmlTags:(NSArray<NSString *> *)tags cssStyle:(NSDictionary<NSString *, id> *)style {
    if (self == nil) {
        return nil;
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    if (tags.count == 2) {
        NSArray *firstRanges = [self rangesOfString:[tags firstObject]];
        NSArray *lastRanges = [self rangesOfString:[tags lastObject]];
        // 倒序遍历避免打乱字符位置顺序
        for (int i = (int)firstRanges.count - 1; i >= 0; i--) {
            if (i >= firstRanges.count || i >= lastRanges.count) {
                break;
            }
            NSRange firstRange = [[firstRanges objectAtIndex:i] rangeValue];
            NSRange lastRange = [[lastRanges objectAtIndex:i] rangeValue];
            NSUInteger location = firstRange.location + firstRange.length;
            NSUInteger length = lastRange.location - location;
            // 排除异常
            if (location == NSNotFound ||
                length == NSNotFound ||
                location + length >= string.length
                ) {
                break;
            }
            // 添加格式
            [string addAttributes:style range:NSMakeRange(location, length)];
            //删除相关标签
            [string deleteCharactersInRange:lastRange];
            [string deleteCharactersInRange:firstRange];
        }
    }
    
    return string;
}

- (BOOL)belongsStrings:(NSArray<NSString *> *)strings {
    for (NSString *string in strings) {
        if ([self isEqualToString:string]) {
            return YES;
        }
    }
    
    return NO;
}

+ (NSString *)md5StringWithString:(NSString *)string {
    const char *cstr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), digest);
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return [result lowercaseString];
}

- (NSString *)md5String {
    return [NSString md5StringWithString:self];
}

+ (NSString *)sha1StringWithString:(NSString *)string {
    NSData *data = [NSData dataWithBytes:string.UTF8String length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

- (NSString *)sha1String {
    return [NSString sha1StringWithString:self];
}

- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex:0];
    
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
    }
    else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

- (BOOL)containsEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    if ([self isEqualToString:@"，"]||
        [self isEqualToString:@"➋"]||
        [self isEqualToString:@"➌"]||
        [self isEqualToString:@"➍"]||
        [self isEqualToString:@"➎"]||
        [self isEqualToString:@"➏"]||
        [self isEqualToString:@"➐"]||
        [self isEqualToString:@"➑"]||
        [self isEqualToString:@"➒"]) {
        
        result = NO;
    }
    
    return result;
}

- (NSString *)filtersEmoji {
    NSMutableString * __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji]) ? @"" : substring];
                          }];
    
    return buffer;
}

@end
