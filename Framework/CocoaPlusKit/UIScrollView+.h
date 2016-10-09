//
//  UIScrollView+CocoaPlus.h
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CocoaPlus)

@property (nonatomic, assign) CGFloat contentInsetTop;
@property (nonatomic, assign) CGFloat contentInsetBottom;
@property (nonatomic, assign) CGFloat contentInsetLeft;
@property (nonatomic, assign) CGFloat contentInsetRight;

@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign) CGFloat contentOffsetY;

@end
