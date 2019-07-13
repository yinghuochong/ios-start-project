//
//  UIView+YHCAddations.m
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import "UIView+YHCAddations.h"
#import <objc/runtime.h>

static char * kUIViewAdditionsFrame1   = "UIViewAdditionsFrame1";
static char * kUIViewAdditionsFrame2   = "UIViewAdditionsFrame2";
static char * kUIViewAdditionsFrame3   = "UIViewAdditionsFrame3";
static char * kUIViewAdditionsFrame4   = "UIViewAdditionsFrame4";
static char * kUIViewAdditionsFrame5   = "UIViewAdditionsFrame5";

static char * kUIViewAdditionsNumber1   = "UIViewAdditionsNumber1";

@implementation UIView (YHCAddations)

- (void)hideView {
    self.hidden = YES;
}

- (void)unhideView {
    self.hidden = NO;
}

- (void)removeAllGestures {
    
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
}

- (BOOL)viewIsVisible {
    
    return self.superview && self.hidden == NO;
}

- (UIView *)rootView {
    
    UIView *rootView = self;
    while (rootView.superview) {
        if ([rootView.superview isKindOfClass:[UIWindow class]]) {
            break;
        }
        rootView = rootView.superview;
    }
    return rootView;
}

- (NSString *)viewFrame1 {
    
    return objc_getAssociatedObject(self, kUIViewAdditionsFrame1);
}

- (void)setViewFrame1:(NSString *)frameStr {
    
    objc_setAssociatedObject(self, kUIViewAdditionsFrame1, frameStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSString *)viewFrame2 {
    
    return objc_getAssociatedObject(self, kUIViewAdditionsFrame2);
}

- (void)setViewFrame2:(NSString *)frameStr {
    
    objc_setAssociatedObject(self, kUIViewAdditionsFrame2, frameStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSString *)viewFrame3 {
    
    return objc_getAssociatedObject(self, kUIViewAdditionsFrame3);
}

- (void)setViewFrame3:(NSString *)frameStr {
    
    objc_setAssociatedObject(self, kUIViewAdditionsFrame3, frameStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSString *)viewFrame4 {
    
    return objc_getAssociatedObject(self, kUIViewAdditionsFrame4);
}

- (void)setViewFrame4:(NSString *)frameStr {
    
    objc_setAssociatedObject(self, kUIViewAdditionsFrame4, frameStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)nonTransformedViewFrame {
    
    return objc_getAssociatedObject(self, kUIViewAdditionsFrame5);
}

- (void)setNonTransformedViewFrame:(NSString *)frameStr {
    
    objc_setAssociatedObject(self, kUIViewAdditionsFrame5, frameStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)viewDistance1 {
    
    return objc_getAssociatedObject(self, kUIViewAdditionsNumber1);
}

- (void)setViewDistance1:(NSNumber *)distance {
    
    objc_setAssociatedObject(self, kUIViewAdditionsNumber1, distance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)setViewFrameByOrig:(CGPoint const *)point {
    
    CGRect rect = self.frame;
    rect.origin = *point;
    self.frame = rect;
}

- (void)setOrigYByAddOffset:(CGFloat)offsetY {
    
    CGRect rect = self.frame;
    rect.origin.y += offsetY;
    self.frame = rect;
}

- (void)setOrigXByAddOffset:(CGFloat)offsetX {
    
    CGRect rect = self.frame;
    rect.origin.x += offsetX;
    self.frame = rect;
}

- (void)changeFrameWidthToValue:(CGFloat)newWidth {
    
    CGRect rect = self.frame;
    rect.size.width = newWidth;
    self.frame = rect;
}

- (void)changeFrameHeightToValue:(CGFloat)newH {
    
    CGRect rect = self.frame;
    rect.size.height = newH;
    self.frame = rect;
}

- (void) fadeOut{
    self.alpha = 0.f;
    for(UIView *subView in self.subviews){
        subView.alpha = 0.f;
    }
}
- (void) fadeIn{
    self.alpha = 1.f;
    for(UIView *subView in self.subviews){
        subView.alpha = 1.f;
    }
}
@end
