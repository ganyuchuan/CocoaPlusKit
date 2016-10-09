//
//  UIImage+CocoaPlus.h
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UIImage (CocoaPlus)

/*!
 *  从工程目录中读取图片
 *
 *  @param name 图片名
 *
 *  @return UIImage对象
 */
+ (UIImage *)imageWithContentsOfFileName:(NSString *)name;

/*!
 *  更改图片颜色
 *
 *  @param tintColor 指定图片颜色
 *  @param blendMode 合成模式
 *
 *  @return UIImage对象
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

/*!
 *  模糊图片
 *
 *  @return UIImage对象
 */
- (UIImage *)blurredImage;

/*!
 *  复制图片
 *
 *  @return UIImage对象
 */
- (UIImage *)duplicate;

/*!
 *  绘制图片
 *
 *  @param image      原始图片
 *  @param text       文本内容
 *  @param attributes 文本属性
 *  @param rect       文本显示区域
 *
 *  @return UIImage对象
 */
+ (UIImage *)drawImage:(UIImage *)image withText:(NSString *)text attributes:(NSDictionary *)attributes inRect:(CGRect)rect;

/*!
 *  通过data读取gif图片
 *
 *  @param data  指定data
 *  @param scale 缩放倍数
 *
 *  @return UIImage对象
 */
+ (UIImage *)gifWithData:(NSData *)data scale:(CGFloat)scale;
+ (UIImage *)gifWithData:(NSData *)data;

/*!
 *  根据图片名读取gif图片
 *
 *  @param name 指定图片名
 *
 *  @return UIImage对象
 */
+ (UIImage *)gifNamed:(NSString *)name;

@end

UIKIT_EXTERN void UIImageGIFRepresentation(UIImage * image, void(^completeBlock)(NSData *data));