//
//  NSDate+CocoaPlus.m
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import "NSDate+.h"

@implementation NSDate (CocoaPlus)

- (NSString *)stringWithDateFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    return [formatter stringFromDate:self];
}

@end
