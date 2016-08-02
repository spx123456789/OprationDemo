//
//  NSObject+Common.h
//  Imora
//
//  Created by wangyuehong on 15/9/12.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ora_Common)

//根据NSError获得tip信息
// NSError的userinfo中如果有msg，则返回msg，否则返回NSError的错误码
- (NSString *)tipFromError:(NSError *)error;

//展示从NSError中获得tip信息
- (BOOL)showError:(NSError *)error;

//展示给定的tip信息
- (void)showHudTipStr:(NSString *)tipStr;
/**
 *  返回任意对象的字符串式的内存地址
 */
-(NSString *)address;


/**
 *  调用方法
 */
-(void)callSelectorWithSelString:(NSString *)selString paramObj:(id)paramObj;

@end
