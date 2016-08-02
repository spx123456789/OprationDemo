//
//  UITextView+Limit.m
//
//  Created by wangyuehong on 15/9/7.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "UITextView+Limit.h"
#import <objc/runtime.h>

@interface Ora_PrivateUITextViewMaxLengthHelper : NSObject

@property(nonatomic, assign) NSUInteger maxLength;
@property(nonatomic, weak) UITextView *textView;
- (instancetype)initWithTextView:(UITextView *)textView maxLength:(NSUInteger)maxLength;

@end

@implementation Ora_PrivateUITextViewMaxLengthHelper

- (instancetype)initWithTextView:(UITextView *)textView maxLength:(NSUInteger)maxLength {
    if (self = [super init]) {
        _textView = textView;
        _maxLength = maxLength;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ora_valueChanged:)
                                                     name:UITextViewTextDidBeginEditingNotification
                                                   object:textView];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ora_valueChanged:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:textView];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ora_valueChanged:)
                                                     name:UITextViewTextDidEndEditingNotification
                                                   object:textView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)ora_valueChanged:(NSNotification *)notification {
    UITextView *textView = [notification object];
    if (textView != self.textView) {
        return;
    }

    if (self.maxLength == 0) {
        return;
    }

    NSUInteger currentLength = [textView.text length];
    if (currentLength <= self.maxLength) {
        return;
    }

    NSString *subString = [textView.text substringToIndex:self.maxLength];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.textView.text = subString;
      [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification
                                                          object:self.textView];
    });
}

@end

@interface UITextView (ora_PrivateMaxLengthHelper)

@property(nonatomic, strong) Ora_PrivateUITextViewMaxLengthHelper *ora_maxLengthHelper;

@end

@implementation UITextView (ora_PrivateMaxLengthHelper)

static void *nlora_maxLengthHelper = &nlora_maxLengthHelper;
- (void)setOra_maxLengthHelper:(Ora_PrivateUITextViewMaxLengthHelper *)ora_maxLengthHelper {
    objc_setAssociatedObject(self, nlora_maxLengthHelper, ora_maxLengthHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Ora_PrivateUITextViewMaxLengthHelper *)ora_maxLengthHelper {
    Ora_PrivateUITextViewMaxLengthHelper *helper = objc_getAssociatedObject(self, nlora_maxLengthHelper);
    if (!helper) {
        helper = [[Ora_PrivateUITextViewMaxLengthHelper alloc] initWithTextView:self maxLength:self.ora_maxLength];
        [self setOra_maxLengthHelper:helper];
    }

    return helper;
}

@end

#pragma mark - Limit

@implementation UITextView (ora_Limit)

static void *nlUITextViewLimitMaxLengthKey = &nlUITextViewLimitMaxLengthKey;

- (void)setOra_maxLength:(NSUInteger)ora_maxLength {
    objc_setAssociatedObject(self, nlUITextViewLimitMaxLengthKey, @(ora_maxLength), OBJC_ASSOCIATION_COPY);
    self.ora_maxLengthHelper.maxLength = ora_maxLength;
}

- (NSUInteger)ora_maxLength {
    return [objc_getAssociatedObject(self, nlUITextViewLimitMaxLengthKey) unsignedIntegerValue];
}

@end
