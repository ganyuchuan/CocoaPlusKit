//
//  NSDate+CocoaPlus.h
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CocoaPlus)

/*!
 *  NSDate对象转为NSString对象
 *
 *  @param format 日期格式 "yyyy-MM-dd HH:mm" ~ "2015-08-14 17:08"
 
 G:      显示AD(公元)
 yy:     显示00~99(年后的2位数)
 yyyy:   显示1970~9999(完整的年)
 M:      显示1~12(1位数或2位数的月份)
 MM:     显示01~12(不足2位数补0的月份)
 MMM:    显示例如Jan(简化的英文月份)
 MMMM:   显示例如January(完整的英文月份)
 d:      显示1~31(1位数或2位数日)
 dd:     显示01~31(不足2位数补0日)
 EEE:    显示例如Sun(简化的英文星期)
 EEEE:   显示例如Sunday(完整的英文星期)
 aa:     显示AM或PM
 H:      显示0~23(1位数或2位数的24小时制)
 HH:     显示00~23(不足2位数补0的24小时制)
 K:      显示0~12(1位数或2位数的12小时制)
 KK:     显示00~12(不足2位数补0的12小时制)
 m:      显示0~59(1位数或2位数分钟)
 mm:     显示00~59(不足2位数补0分钟)
 s:      显示0~59(1位数或2位数秒)
 ss:     显示00~59(不足2位数补0秒)
 S:      显示毫秒
 
 *
 *  @return NSString类型
 */
- (NSString *)stringWithDateFormat:(NSString *)format;

@end
