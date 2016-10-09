//
//  UITableViewCell+CocoaPlus.m
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import "UITableViewCell+.h"

@implementation UITableViewCell (CocoaPlus)

- (void)setSeparatorInsetLeft:(CGFloat)left right:(CGFloat)right {
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, left, 0, right)];
    }
}

@end
