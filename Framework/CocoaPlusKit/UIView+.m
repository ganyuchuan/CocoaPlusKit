//
//  UIView+CocoaPlus.m
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import "UIView+.h"

@implementation UIView (CocoaPlus)

#pragma mark - Getters

- (CGFloat)frameX {
    return self.frame.origin.x;
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (CGPoint)frameOrigin {
    return self.frame.origin;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

#pragma mark - Setters

- (void)setFrameX:(CGFloat)frameX {
    self.frame = CGRectMake(frameX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameY:(CGFloat)frameY {
    self.frame = CGRectMake(self.frame.origin.x, frameY, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameWidth:(CGFloat)frameWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, frameWidth, self.frame.size.height);
}

- (void)setFrameHeight:(CGFloat)frameHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameHeight);
}

- (void)setFrameOrigin:(CGPoint)frameOrigin {
    self.frame = CGRectMake(frameOrigin.x, frameOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

#pragma mark - Public

- (void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (id)firstSubviewWithClass:(Class)cls {
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:cls]) {
            return subview;
        }
    }
    
    return nil;
}

@end
