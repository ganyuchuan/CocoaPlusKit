//
//  CocoaPlusMacro.h
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#ifndef CocoaPlusMacro_h
#define CocoaPlusMacro_h

#define CP_HEIGHT_TABBAR            49
#define CP_HEIGHT_NAVIGATIONBAR     44
#define CP_HEIGHT_STATUSBAR         20
#define CP_HEIGHT_TOOLBAR           44
#define CP_HEIGHT_KEYBOARD          216

#define CP_WINDOW                   [[UIApplication sharedApplication] keyWindow]

#define CP_SIZE_PHONE4              CGSizeMake(320, 480)
#define CP_SIZE_PHONE5              CGSizeMake(320, 568)
#define CP_SIZE_PHONE6              CGSizeMake(375, 667)
#define CP_SIZE_PHONE6P             CGSizeMake(414, 736)

#define CP_SCREEN_BOUNDS            [UIScreen mainScreen].bounds
#define CP_SCREEN_SIZE              [UIScreen mainScreen].bounds.size
#define CP_SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
#define CP_SCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height
#define CP_SCREEN_CENTER            CGPointMake(thisScreenWidth/2.0, thisScreenHeight/2.0)
#define CP_SCREEN_SCALE             [UIScreen mainScreen].scale

// 真机
#if TARGET_OS_IPHONE
#define CP_IS_DEVICE                YES
#else
#define CP_IS_DEVICE                NO
#endif
// 模拟器
#if TARGET_IPHONE_SIMULATOR
#define CP_IS_SIMULATOR             YES
#else
#define CP_IS_SIMULATOR             NO
#endif

// 是否使用ARC编译
#if __has_feature(objc_arc)
#define CP_IS_ARC                   YES
#else
#define CP_IS_ARC                   NO
#endif

// 系统版本
#define CP_VERSION_SYS              [[UIDevice currentDevice] systemVersion]
// App版本
#define CP_VERSION_APP              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 沙盒根路径
#define CP_PATH_ROOT                NSHomeDirectory()
// 沙盒Documents目录路径
#define CP_PATH_DOCUMENTS           [NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]]
// 沙盒Library目录路径
#define CP_PATH_LIBRARY             [NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]]
// 沙盒Caches目录路径
#define CP_PATH_CACHES              [NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]]
// 沙盒Preferences目录路径
#define CP_PATH_PREFERENCES         [NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) firstObject]]
// 沙盒tmp目录路径
#define CP_PATH_TMP                 NSTemporaryDirectory()

#define CP_GCD_GLOBAL(block)        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define CP_GCD_MAIN(block)          dispatch_async(dispatch_get_main_queue(),block)

#endif /* CocoaPlusMacro_h */
