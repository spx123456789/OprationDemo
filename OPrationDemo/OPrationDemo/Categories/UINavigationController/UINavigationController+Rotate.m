//
//  UINavigationController+rotate.m
//  TestRotate
//
//  Created by wangyuehong on 15/8/7.
//  Copyright (c) 2015年 oradt. All rights reserved.
//

#import "UINavigationController+Rotate.h"

@implementation UINavigationController (ora_rotate)

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

@end
