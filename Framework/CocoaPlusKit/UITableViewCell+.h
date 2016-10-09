//
//  UITableViewCell+CocoaPlus.h
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CocoaPlus)

/*!
 *  设置cell分割线的左右边距
 *
 *  @param left  左边距
 *  @param right 右边距
 */
- (void)setSeparatorInsetLeft:(CGFloat)left right:(CGFloat)right;

@end
