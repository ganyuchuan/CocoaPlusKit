//
//  UIScrollView+CocoaPlus.m
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import "UIScrollView+.h"

@implementation UIScrollView (CocoaPlus)

#pragma mark - Getters

- (CGFloat)contentInsetTop {
    return self.contentInset.top;
}

- (CGFloat)contentInsetBottom {
    return self.contentInset.bottom;
}

- (CGFloat)contentInsetLeft {
    return self.contentInset.left;
}

- (CGFloat)contentInsetRight {
    return self.contentInset.right;
}

- (CGFloat)contentOffsetX {
    return self.contentOffset.x;
}

- (CGFloat)contentOffsetY {
    return self.contentOffset.y;
}

#pragma mark - Setters

- (void)setContentInsetTop:(CGFloat)contentInsetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = contentInsetTop;
    self.contentInset = inset;
}

- (void)setContentInsetBottom:(CGFloat)contentInsetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = contentInsetBottom;
    self.contentInset = inset;
}

- (void)setContentInsetLeft:(CGFloat)contentInsetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = contentInsetLeft;
    self.contentInset = inset;
}

- (void)setContentInsetRight:(CGFloat)contentInsetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = contentInsetRight;
    self.contentInset = inset;
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX {
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    self.contentOffset = offset;
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    self.contentOffset = offset;
}

@end
