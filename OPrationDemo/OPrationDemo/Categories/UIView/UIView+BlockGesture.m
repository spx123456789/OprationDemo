//
//  UIView+BlockGesture.m
//
//  Created by wangyuehong on 15/9/6.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "UIView+BlockGesture.h"
#import "NSObject+associatedObject.h"

static char kActionHandlerTapBlockKey;
static char kActionHandlerLongPressBlockKey;

@implementation UIView (ora_BlockGesture)

- (void)ora_addTapActionWithBlock:(GestureActionBlock)block {
    UITapGestureRecognizer *gesture = [self ora_associatedValueForKey:_cmd];
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ora_handleActionForTapGesture:)];
        gesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:gesture];
        [self ora_setAssociateValue:gesture withKey:_cmd];
    }

    [self ora_setAssociateCopyValue:block withKey:&kActionHandlerTapBlockKey];
    self.userInteractionEnabled = YES;
}

- (void)ora_removeTapAction {
    GestureActionBlock block = [self ora_associatedValueForKey:&kActionHandlerTapBlockKey];
    if (block) {
        NSArray *gestures = [self gestureRecognizers];
        [gestures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
          UIGestureRecognizer *gesture = obj;
          if ([gesture isMemberOfClass:[UITapGestureRecognizer class]]) {
              [gesture removeTarget:self action:@selector(ora_handleActionForTapGesture:)];
          }
        }];
        [self ora_setAssociateCopyValue:nil withKey:&kActionHandlerTapBlockKey];
    }
}

- (void)ora_handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = [self ora_associatedValueForKey:&kActionHandlerTapBlockKey];
        if (block) {
            block(gesture);
        }
    }
}

- (void)ora_addLongPressActionWithBlock:(GestureActionBlock)block {
    UILongPressGestureRecognizer *gesture = [self ora_associatedValueForKey:_cmd];
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(ora_handleActionForLongPressGesture:)];
        gesture.minimumPressDuration = 1;
        [self addGestureRecognizer:gesture];
        [self ora_setAssociateValue:gesture withKey:_cmd];
    }

    [self ora_setAssociateCopyValue:block withKey:&kActionHandlerLongPressBlockKey];
    self.userInteractionEnabled = YES;
}

- (void)ora_removeLongPressAction {
    GestureActionBlock block = [self ora_associatedValueForKey:&kActionHandlerLongPressBlockKey];
    if (block) {
        NSArray *gestures = [self gestureRecognizers];
        [gestures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
          UIGestureRecognizer *gesture = obj;
          if ([gesture isMemberOfClass:[UILongPressGestureRecognizer class]]) {
              [gesture removeTarget:self action:@selector(ora_handleActionForLongPressGesture:)];
          }
        }];
        [self ora_setAssociateCopyValue:nil withKey:&kActionHandlerLongPressBlockKey];
    }
}

- (void)ora_handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = [self ora_associatedValueForKey:&kActionHandlerLongPressBlockKey];
        if (block) {
            block(gesture);
        }
    }
}

@end
