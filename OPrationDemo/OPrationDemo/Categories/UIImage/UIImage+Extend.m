//
//  UIImage+Extend.m
//  CDHN
//
//  Created by muxi on 14-10-14.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import "UIImage+Extend.h"
#import "CoreConst.h"
#import <objc/runtime.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Accelerate/Accelerate.h>

static const void *CompleteBlockKey = &CompleteBlockKey;
static const void *FailBlockKey = &FailBlockKey;

@interface UIImage ()

@property(nonatomic, copy) void (^CompleteBlock)();

@property(nonatomic, copy) void (^FailBlock)();

@end

@implementation UIImage (Extend)

/**
 *  获取启动图片
 */
+ (UIImage *)launchImage {
    NSString *imageName = @"LaunchImage-700";

    if (iphone5x_4_0) imageName = @"LaunchImage-700-568h";

    return [UIImage imageNamed:imageName];
}

/**
 *  根据不同的iphone屏幕大小自动加载对应的图片名
 *  加载规则：
 *  iPhone4:             默认图片名，无后缀
 *  iPhone5系列:          _ip5
 *  iPhone6:             _ip6
 *  iPhone6 Plus:     _ip6p,注意屏幕旋转显示不同的图片不是这个方法能决定的，需要使用UIImage的sizeClass特性决定
 */
+ (UIImage *)deviceImageNamed:(NSString *)name {
    NSString *imageName = [name copy];

    // iphone5
    if (iphone5x_4_0) imageName = [NSString stringWithFormat:@"%@%@", imageName, @"_ip5"];

    // iphone6
    if (iphone6_4_7) imageName = [NSString stringWithFormat:@"%@%@", imageName, @"_ip6"];

    // iphone6 Plus
    if (iphone6Plus_5_5) imageName = [NSString stringWithFormat:@"%@%@", imageName, @"_ip6p"];

    UIImage *originalImage = [UIImage imageNamed:name];

    UIImage *deviceImage = [UIImage imageNamed:imageName];

    if (deviceImage == nil) deviceImage = originalImage;

    return deviceImage;
}

/**
 *  拉伸图片
 */
#pragma mark 拉伸图片:自定义比例
+ (UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap {
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * leftCap topCapHeight:image.size.height * topCap];
}

#pragma mark 拉伸图片
+ (UIImage *)resizeWithImageName:(NSString *)name {
    return [self resizeWithImageName:name leftCap:.5f topCap:.5f];
}

- (void)ora_savedPhotosAlbum:(void (^)())completeBlock failBlock:(void (^)())failBlock;
{
    [self createAlbumInPhoneAlbum];
    self.CompleteBlock = completeBlock;
    self.FailBlock = failBlock;
}

/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param completeBlock 出错回调
 */
- (void)savedPhotosAlbum:(void (^)())completeBlock failBlock:(void (^)())failBlock {
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    self.CompleteBlock = completeBlock;
    self.FailBlock = failBlock;
}

#pragma mark - 在手机相册中创建相册
- (void)createAlbumInPhoneAlbum {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
      if (group) {
          [groups addObject:group];
      }

      else {
          BOOL haveHDRGroup = NO;

          for (ALAssetsGroup *gp in groups) {
              NSString *name = [gp valueForProperty:ALAssetsGroupPropertyName];

              if ([name isEqualToString:[UIDevice currentDevice].appName]) {
                  haveHDRGroup = YES;
              }
          }

          if (!haveHDRGroup) {
              // do add a group named "XXXX"
              [assetsLibrary addAssetsGroupAlbumWithName:[UIDevice currentDevice].appName
                                             resultBlock:^(ALAssetsGroup *group) {
                                               [groups addObject:group];

                                             }
                                            failureBlock:nil];
              haveHDRGroup = YES;
          }
      }

    };
    //创建相簿
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];

    [self saveToAlbumWithMetadata:nil
        imageData:UIImagePNGRepresentation(self)
        customAlbumName:[UIDevice currentDevice].appName
        completionBlock:^{
          //这里可以创建添加成功的方法
          dispatch_async(dispatch_get_main_queue(), ^{
            self.CompleteBlock();
          });
        }
        failureBlock:^(NSError *error) {
          //处理添加失败的方法显示alert让它回到主线程执行，不然那个框框死活不肯弹出来
          dispatch_async(dispatch_get_main_queue(), ^{

            //添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
            if ([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound ||
                [error.localizedDescription rangeOfString:@"用户拒绝访问"].location != NSNotFound) {
            }
            if (self.FailBlock != nil) self.FailBlock();
          });
        }];
}
- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    @weakify(assetsLibrary) void (^AddAsset)(ALAssetsLibrary *, NSURL *) =
        ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
          [assetsLibrary assetForURL:assetURL
              resultBlock:^(ALAsset *asset) {
                [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                    usingBlock:^(ALAssetsGroup *group, BOOL *stop) {

                      if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                          [group addAsset:asset];
                          if (completionBlock) {
                              completionBlock();
                          }
                      }
                    }
                    failureBlock:^(NSError *error) {
                      if (failureBlock) {
                          failureBlock(error);
                      }
                    }];
              }
              failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
              }];
        };
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData
                                           metadata:metadata
                                    completionBlock:^(NSURL *assetURL, NSError *error) {
                                      if (customAlbumName) {
                                          [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName
                                              resultBlock:^(ALAssetsGroup *group) {
                                                @strongify(assetsLibrary);

                                                if (group) {
                                                    [assetsLibrary assetForURL:assetURL
                                                        resultBlock:^(ALAsset *asset) {
                                                          [group addAsset:asset];
                                                          if (completionBlock) {
                                                              completionBlock();
                                                          }
                                                        }
                                                        failureBlock:^(NSError *error) {
                                                          if (failureBlock) {
                                                              failureBlock(error);
                                                          }
                                                        }];
                                                } else {
                                                    AddAsset(assetsLibrary, assetURL);
                                                }
                                              }
                                              failureBlock:^(NSError *error) {
                                                @strongify(assetsLibrary);

                                                AddAsset(assetsLibrary, assetURL);
                                              }];
                                      } else {
                                          if (completionBlock) {
                                              completionBlock();
                                          }
                                      }
                                    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        if (self.CompleteBlock != nil) self.CompleteBlock();
    } else {
        if (self.FailBlock != nil) self.FailBlock();
    }
}

/*
 *  模拟成员变量
 */
- (void (^)())FailBlock {
    return objc_getAssociatedObject(self, FailBlockKey);
}
- (void)setFailBlock:(void (^)())FailBlock {
    objc_setAssociatedObject(self, FailBlockKey, FailBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)())CompleteBlock {
    return objc_getAssociatedObject(self, CompleteBlockKey);
}

- (void)setCompleteBlock:(void (^)())CompleteBlock {
    objc_setAssociatedObject(self, CompleteBlockKey, CompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)remakeImageWithFullSize:(CGSize)fullSize zoom:(CGFloat)zoom {
    //新建上下文
    UIGraphicsBeginImageContextWithOptions(fullSize, NO, 0.0);

    //图片原本size
    CGSize size_orignal = self.size;
    CGFloat sizeW = size_orignal.width * zoom;
    CGFloat sizeH = size_orignal.height * zoom;
    CGFloat x = (fullSize.width - sizeW) * .5f;
    CGFloat y = (fullSize.height - sizeH) * .5f;
    CGRect rect = CGRectMake(x, y, sizeW, sizeH);

    [self drawInRect:rect];

    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    //结束上下文
    UIGraphicsEndImageContext();

    return newImage;
}

/*
 *  生成一个默认的占位图片：bundle默认图片
 */
+ (UIImage *)phImageWithSize:(CGSize)fullSize zoom:(CGFloat)zoom {
    return [[UIImage imageNamed:@"CoreSDWebImage.bundle/empty_picture"] remakeImageWithFullSize:fullSize zoom:zoom];
}

- (UIImage *)applyLightEffect {
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyExtraLightEffect {
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyDarkEffect {
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor {
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    long componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    } else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage {
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog(@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width,
              self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog(@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog(@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }

    CGRect imageRect = {CGPointZero, self.size};
    UIImage *effectImage = self;

    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);

        vImage_Buffer effectInBuffer;
        effectInBuffer.data = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);

        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);

        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1;  // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0,
                                       kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0,
                                       kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0,
                                       kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s, 0.0722 - 0.0722 * s, 0.0722 - 0.0722 * s, 0, 0.7152 - 0.7152 * s,
                0.7152 + 0.2848 * s, 0.7152 - 0.7152 * s, 0, 0.2126 - 0.2126 * s, 0.2126 - 0.2126 * s,
                0.2126 + 0.7873 * s, 0, 0, 0, 0, 1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix) / sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL,
                                              kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            } else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL,
                                              kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped) effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        if (effectImageBuffersAreSwapped) effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);

    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);

    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }

    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }

    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return outputImage;
}

@end
