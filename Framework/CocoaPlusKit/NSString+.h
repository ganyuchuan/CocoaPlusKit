//
//  NSString+CocoaPlus.h
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (CocoaPlus)

/*!
 *  计算字符串的宽高
 *
 *  @param attrs 属性值
 *  @param width 固定宽
 *
 *  @return CGSize结构体
 */
- (CGSize)sizeWithAttributes:(NSDictionary<NSString *,id> *)attrs fixedWidth:(CGFloat)width;
/*!
 *  计算字符串的宽高
 *
 *  @param attrs  属性值
 *  @param height 固定高
 *
 *  @return CGSize结构体
 */
- (CGSize)sizeWithAttributes:(NSDictionary<NSString *,id> *)attrs fixedHeight:(CGFloat)height;

/*!
 *  是否为有效的邮箱格式
 *
 *  @return BOOL值
 */
- (BOOL)isValidEmail;
/*!
 *  是否为有效的手机号码格式
 *
 *  @return BOOL值
 */
- (BOOL)isValidPhone;
/*!
 *  是否为空字符串
 *
 *  @return BOOL值
 */
- (BOOL)isBlankString;

/*!
 *  获取某一字符串在当前字符串中的所有范围
 *
 *  @param string 指定某一字符串
 *
 *  @return 封装着NSValue的NSArray对象
 */
- (NSArray<NSValue *> *)rangesOfString:(NSString *)string;
/*!
 *  给当前特殊格式（比如@"Hello <btn>World</btn>!"）的字符串生成富文本
 *
 *  @param attributes 标签外的内容属性值，比如给 @"Hello !"指定富文本属性
 *  @param tags       标签数组，比如指定标签数组为 @[@"<btn>", @"</btn>"]
 *  @param style      标签中的内容属性值，比如给 @"World"指定富文本属性
 *
 *  @return NSAttributedString对象
 */
- (NSAttributedString *)attributedStringWithAttributes:(NSDictionary<NSString *, id> *)attributes xmlTags:(NSArray<NSString *> *)tags cssStyle:(NSDictionary<NSString *, id> *)style;

/*!
 *  是否属于某一系列字符串数组中的元素
 *
 *  @param strings 指定某一些列字符串数组
 *
 *  @return BOOL值
 */
- (BOOL)belongsStrings:(NSArray<NSString *> *)strings;

/*!
 *  md5加密
 *
 *  @param string 需加密字符串
 *
 *  @return 密文
 */
+ (NSString *)md5StringWithString:(NSString *)string;
- (NSString *)md5String;

/*!
 *  sha1加密
 *
 *  @param string 需加密字符串
 *
 *  @return 密文
 */
+ (NSString *)sha1StringWithString:(NSString *)string;
- (NSString *)sha1String;

/*!
 *  是否为emoji表情
 *
 *  @return BOOL值
 */
- (BOOL)isEmoji;
/*!
 *  是否包含emoji表情
 *
 *  @return BOOL值
 */
- (BOOL)containsEmoji;
/*!
 *  过滤掉当前字符串中的emoji表情
 *
 *  @return BOOL值
 */
- (NSString *)filtersEmoji;

@end
