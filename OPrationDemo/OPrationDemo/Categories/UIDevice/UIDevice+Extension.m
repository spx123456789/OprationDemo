//
//  UIDevice+Extension.m
//  Imora
//
//  Created by wangyuehong on 15/12/9.
//  Copyright © 2015年 Oradt. All rights reserved.
//

#include <arpa/inet.h>
#include <ifaddrs.h>
#import <sys/sysctl.h>
#import <sys/types.h>
#import "UIDevice+Extension.h"
static char *locationManagerKey = "locationManagerKey";
static char *callbackKey = "callbackKey";
@interface UIDevice ()
@end
@implementation UIDevice (Extension)

- (NSString *)appName {
    // NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    // return [infoDict objectForKey:@"CFBundleDisplayName"];
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

- (NSString *)appVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)appBuildVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleVersion"];
}

- (NSString *)detailModel {
    int mib[2];
    size_t len;
    char *machine;

    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);

    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);

    //    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    //    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    //    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    //    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    //    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    //    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    //    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    //    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    //    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    //    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    //    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    //    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    //    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    //    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    //    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    //    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    //    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    //
    //    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    //    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    //    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    //    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    //    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    //
    //    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    //
    //    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    //    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    //    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    //    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    //    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    //    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    //    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    //
    //    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    //    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    //    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    //    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    //    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    //    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    //
    //    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    //    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    //    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    //    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    //    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    //    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    //
    //    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    //    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    return platform;

    // return objc_getAssociatedObject(self, &detailModelKey);
}

- (NSString *)ip {
//    NSString *address = @"";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//
//    success = getifaddrs(&interfaces);
//
//    if (success == 0) {  // 0 表示获取成功
//
//        temp_addr = interfaces;
//        while (temp_addr != NULL) {
//            if (temp_addr->ifa_addr->sa_family == AF_INET) {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
//                    // Get NSString from C String
//                    address = [NSString
//                        stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//
//    freeifaddrs(interfaces);

//    return address;
    return @"127.0.0.1";
}
@end
