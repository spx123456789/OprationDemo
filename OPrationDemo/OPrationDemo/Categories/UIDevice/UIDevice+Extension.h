//
//  UIDevice+Extension.h
//  Imora
//
//  Created by wangyuehong on 15/12/9.
//  Copyright © 2015年 Oradt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DeviceCallback)(id data, NSError *error);
@interface UIDevice (Extension)

// 手机型号  如：iPhone 5C iPhone 6 iPhone 6 Plus等
@property(nonatomic, copy, readonly) NSString *detailModel;

// App 名称 当前返回 Imora
@property(nonatomic, copy, readonly) NSString *appName;

// App 版本号
@property(nonatomic, copy, readonly) NSString *appVersion;

// Build 版本号
@property(nonatomic, copy, readonly) NSString *appBuildVersion;

// IP地址
@property(nonatomic, copy, readonly) NSString *ip;
/**
 *  判断是否开启了位置访问权限(包括系统位置开关和当前App访问许可开关)
 */
@property(nonatomic, assign, readonly) BOOL locationAuthorized;
- (BOOL)getCurrentLocation:(DeviceCallback)callback;
@end
