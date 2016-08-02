//
//  UINavigationController+Ext.m
//  Imora
//
//  Created by liulb on 16/1/19.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import "UINavigationController+Ext.h"

@implementation UINavigationController (Ext)
- (void)setTransparent:(BOOL)transparent {
    if (transparent) {
        //透明
        UIGraphicsBeginImageContextWithOptions(self.navigationBar.frame.size, NO, [UIScreen mainScreen].scale);
        UIImage* bgImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsCompact /*UIBarMetricsDefault*/];

        self.navigationBar.translucent = YES;
        self.navigationBar.backgroundColor = [UIColor clearColor];
    } else {
        self.navigationBar.translucent = NO;
    }
}
@end
