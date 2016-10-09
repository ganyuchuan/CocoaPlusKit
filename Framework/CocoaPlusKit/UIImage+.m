//
//  UIImage+CocoaPlus.m
//  CocoaPlusKit
//
//  Created by huxiu on 16/10/9.
//  Copyright © 2016年 ganyuchuan. All rights reserved.
//

#import "UIImage+.h"
#import "CocoaPlusMacro.h"

static NSData * __nullable createAnimatedGIF(NSArray *frameImages, float delayTime) {
    // 设置循环次数
    NSDictionary *fileProperties = @{(__bridge id)kCGImagePropertyGIFDictionary:@{
                                             (__bridge id)kCGImagePropertyGIFLoopCount: @0, // 0代表永远循环下去
                                             (__bridge id)kCGImagePropertyGIFHasGlobalColorMap:@(NO) // 不具备全局颜色表，减少内存消耗
                                             }
                                     };
    // 设置每帧停留时长
    NSDictionary *frameProperties = @{(__bridge id)kCGImagePropertyGIFDictionary:@{
                                              (__bridge id)kCGImagePropertyGIFDelayTime:@(delayTime) // delayTime必须为float类型
                                              }
                                      };
    
    // 创建数据存放容器
    NSMutableData *data = [NSMutableData data];
    
    // 创建CGImageDestination
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)data, kUTTypeGIF, frameImages.count, NULL);
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)fileProperties);
    // 遍历图片数组
    for (UIImage *frameImage in frameImages) {
        @autoreleasepool {
            CGImageDestinationAddImage(destination, frameImage.CGImage, (__bridge CFDictionaryRef)frameProperties);
        }
    }
    
    // 获取结果
    BOOL success = CGImageDestinationFinalize(destination);
    CFRelease(destination);
    if (!success) {
        NSLog(@"Failed to finalize image destination.");
        return nil;
    }
    
    return data;
}

//static BOOL containAnimatedGIF(CGImageSourceRef imageSource) {
//    return imageSource && UTTypeConformsTo(CGImageSourceGetType(imageSource), kUTTypeGIF) && CGImageSourceGetCount(imageSource) > 1;
//}

@implementation UIImage (CocoaPlus)

+ (UIImage *)imageWithContentsOfFileName:(NSString *)name {
    return [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    // 保留alpha值并设置比例大小相同
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    // 在上下文设备中进行绘制
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    // 如果没有使用透明绘制则再使用透明进行绘制
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    // 获得图像并结束绘制
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *)blurredImage {
    CIContext *context   = [CIContext contextWithOptions:nil];
    CIImage *inputImage  = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter     = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0f] forKey:@"inputRadius"];
    CIImage *result      = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage   = [context createCGImage:result fromRect:[inputImage extent]];
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}

- (UIImage *)duplicate {
    return [UIImage imageWithCGImage:[self CGImage]];
}

+ (UIImage *)drawImage:(UIImage *)image withText:(NSString *)text attributes:(NSDictionary *)attributes inRect:(CGRect)rect {
    if (image == nil) {
        return nil;
    }
    if (text == nil) {
        return image;
    }
    
    if (image.images.count > 1) {
        NSMutableArray *frameImages = [NSMutableArray array];
        // 遍历每帧图片重新进新绘制
        for (UIImage *img in image.images) {
            UIImage *frameImage = [self drawImage:img withText:text attributes:attributes inRect:rect];
            // 放入容器
            if (frameImage) [frameImages addObject:frameImage];
        }
        
        // 导出
        float delayTime = image.duration / image.images.count;
        NSData *data = createAnimatedGIF(frameImages, delayTime);
        if (data) return [self gifWithData:data];
        else return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(image.size, YES, CP_SCREEN_SCALE);
    // 绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    // 绘制文本
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    [string drawInRect:CGRectIntegral(rect)];
    
    // 从上下文中获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)gifWithData:(NSData *)data {
    return [self gifWithData:data scale:1];
}

+ (UIImage *)gifWithData:(NSData *)data scale:(CGFloat)scale {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}


+ (UIImage *)gifNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [self gifWithData:data scale:scale];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [self gifWithData:data scale:scale];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [self gifWithData:data scale:scale];
        }
        
        return [UIImage imageNamed:name];
    }
}

@end

void UIImageGIFRepresentation(UIImage * image, void(^completeBlock)(NSData *data)) {
    CP_GCD_GLOBAL(^{
        NSData *data = createAnimatedGIF(image.images, image.duration / image.images.count);
        CP_GCD_MAIN(^{completeBlock(data);});
    });
}
