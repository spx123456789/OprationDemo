//
//  NSObject+AssociatedObject.h
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ora_associatedObject)

- (void)ora_setAssociateValue:(id)value withKey:(void *)key;  // Strong reference
- (void)ora_setAssociateWeakValue:(id)value withKey:(void *)key;
- (void)ora_setAssociateCopyValue:(id)value withKey:(void *)key;
- (id)ora_associatedValueForKey:(void *)key;

@end
