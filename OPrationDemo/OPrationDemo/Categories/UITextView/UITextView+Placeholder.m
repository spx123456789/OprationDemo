//
//  UITextView+ora_PlaceHolder.m
//
//  Created by wangyuehong on 15/9/7.
//  Copyright (c) 2015年 Oradt. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static NSString *const kHoomicNotificationDidChangeTextView = @"kHoomicNotificationDidChangeTextView";

@interface NLAutoPreferredMaxLayoutWidthLabel : UILabel

@end

@implementation NLAutoPreferredMaxLayoutWidthLabel

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];

    self.preferredMaxLayoutWidth = CGRectGetWidth(bounds);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.preferredMaxLayoutWidth = MAX((CGRectGetWidth(self.superview.frame) - CGRectGetMinX(self.frame)), 0);

    /**
     *  @brief  第一次调用 [super layoutSubviews] 是为了获得 label 的
     * frame，而第二次调用是为了改变后更新布局。如果省略第二个调用我们可能会会得到一个 NSInternalInconsistencyException
     * 的错误，因为我们改变了更新约束条件的布局操作，但我们并没有再次触发布局。
     */
    [super layoutSubviews];
}

@end

@interface NLTextViewPlaceholderHelper : NSObject

@property(nonatomic, weak) UITextView *textView;
- (instancetype)initWithTextView:(UITextView *)textView;

@end

@interface UITextView (ora_PlaceholderHelper)

@property(nonatomic, strong, readonly) UILabel *ora_lblPlaceholder;
@property(nonatomic, strong, readonly) NLTextViewPlaceholderHelper *ora_placeholderHelper;

@end

#pragma mark - ora_Placeholder
@implementation UITextView (ora_Placeholder)

+ (void)load {
    Method ora_setAttributedText = class_getInstanceMethod(self, @selector(ora_setAttributedText:));
    Method setAttributedText = class_getInstanceMethod(self, @selector(setAttributedText:));

    if (setAttributedText && ora_setAttributedText) {
        method_exchangeImplementations(ora_setAttributedText, setAttributedText);
    }
}

- (void)ora_setAttributedText:(NSAttributedString *)attributedText {
    [self ora_setAttributedText:attributedText];

    if (self.ora_isDidChangePostNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHoomicNotificationDidChangeTextView object:self];
    }
}

- (void)setOra_placeholder:(NSString *)ora_placeholder {
    [self.ora_lblPlaceholder setText:ora_placeholder];

    [self setNeedsDisplay];
}

- (NSString *)ora_placeholder {
    return [self.ora_lblPlaceholder text];
}

- (void)setOra_placeholderColor:(UIColor *)ora_placeholderColor {
    [self.ora_lblPlaceholder setTextColor:ora_placeholderColor];
}

- (UIColor *)ora_placeholderColor {
    return [self.ora_lblPlaceholder textColor];
}

- (void)setOra_placeholderFont:(UIFont *)ora_placeholderFont {
    [self.ora_lblPlaceholder setFont:ora_placeholderFont];
}

- (UIFont *)ora_placeholderFont {
    return [self.ora_lblPlaceholder font];
}

- (void)setOra_isDidChangePostNotification:(BOOL)ora_isDidChangePostNotification {
    objc_setAssociatedObject(self, @selector(ora_isDidChangePostNotification), @(ora_isDidChangePostNotification),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ora_isDidChangePostNotification {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end

#pragma mark - ora_PlaceholderHelper
@implementation UITextView (ora_PlaceholderHelper)

- (UILabel *)ora_lblPlaceholder {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UILabel *lblPlaceholder = [[NLAutoPreferredMaxLayoutWidthLabel alloc] init];
        [lblPlaceholder setTextColor:[UIColor colorWithWhite:0.789 alpha:1.0]];
        [lblPlaceholder setFont:[self font]];
        [lblPlaceholder setNumberOfLines:0];

        [self insertSubview:lblPlaceholder atIndex:0];

        lblPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *constraintVs =
            [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7.5-[lblPlaceholder]"
                                                    options:0
                                                    metrics:nil
                                                      views:NSDictionaryOfVariableBindings(lblPlaceholder)];

        NSArray *constraintHs =
            [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[lblPlaceholder]-6-|"
                                                    options:0
                                                    metrics:nil
                                                      views:NSDictionaryOfVariableBindings(lblPlaceholder)];
        [self addConstraints:constraintHs];
        [self addConstraints:constraintVs];

        objc_setAssociatedObject(self, _cmd, lblPlaceholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        if ([self.text length] > 0) {
            [lblPlaceholder setHidden:YES];
        }

        [self ora_placeholderHelper];
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (NLTextViewPlaceholderHelper *)ora_placeholderHelper {
    if (!objc_getAssociatedObject(self, _cmd)) {
        NLTextViewPlaceholderHelper *helper = [[NLTextViewPlaceholderHelper alloc] initWithTextView:self];
        objc_setAssociatedObject(self, _cmd, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

@end

#pragma mark - NLTextViewPlaceholderHelper
@implementation NLTextViewPlaceholderHelper

- (void)didChange:(NSNotification *)notification {
    [self changePlaceholderHidden];
}

- (void)changePlaceholderHidden {
    self.textView.ora_lblPlaceholder.hidden = self.textView.text.length > 0;
}

- (instancetype)initWithTextView:(UITextView *)textView {
    if (self = [super init]) {
        _textView = textView;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChange:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:textView];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChange:)
                                                     name:kHoomicNotificationDidChangeTextView
                                                   object:textView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end