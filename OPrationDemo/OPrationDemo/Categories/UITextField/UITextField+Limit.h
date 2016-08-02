//
//  UITextField+Limit.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

/**
 eg
 UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 150, 50)];
 textField.maxLength = 10;
 textField.placeholder = @"最大10个字符";
 **/

#import <UIKit/UIKit.h>

@interface UITextField (ora_Limit)

//限制UITextField输入的最大长度
@property(nonatomic, assign) NSUInteger ora_maxLength;

@end
