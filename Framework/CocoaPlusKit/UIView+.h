//
//  UIView+CocoaPlus.h
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CocoaPlus)

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;
@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;
@property (nonatomic) CGPoint frameOrigin;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

/*!
 *  移除所有子视图
 */
- (void)removeAllSubviews;
/*!
 *  获取指定类下的第一个子视图
 *
 *  @param cls 指定类
 *
 *  @return UIView子类对象
 */
- (id)firstSubviewWithClass:(Class)cls;

@end
