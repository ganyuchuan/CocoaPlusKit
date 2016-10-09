//
//  UIColor+CocoaPlus.h
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorRGBA(r, g, b, a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorRGB(r, g, b)       UIColorRGBA(r, g, b, 1.0f)

@interface UIColor (CocoaPlus)

@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) NSString *colorSpaceString;

@property (nonatomic, readonly) BOOL isRGB;

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat white;
@property (nonatomic, readonly) CGFloat alpha;

@property (nonatomic, readonly) UInt32 rgbHex;

/*!
 *  得到RGB颜色值
 *
 *  @param red   红色值
 *  @param green 绿色值
 *  @param blue  蓝色值
 *  @param alpha 透明度
 *
 *  @return BOOL值，是否取值成功
 */
- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;

/*!
 *  获取一个随机色
 *
 *  @return UIColor对象
 */
+ (UIColor *)randomColor;

/*!
 *  根据16进制值新建一个RGB颜色
 *
 *  @param hex 16进制值
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBHexString:(NSString *)hexString;

/*!
 *  新建一个RGB颜色
 *
 *  @param red   红色值，0～255
 *  @param green 绿色值，0～255
 *  @param blue  蓝色值，0～255
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

@end
