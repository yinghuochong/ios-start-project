//
//  UIView+YHCAddations.h
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YHCAddations)

- (void)hideView;
- (void)unhideView;
- (void)removeAllGestures;
- (BOOL)viewIsVisible;
- (UIView *)rootView;


- (NSString *)viewFrame1;
- (void)setViewFrame1:(NSString *)frameStr;

- (NSString *)viewFrame2;
- (void)setViewFrame2:(NSString *)frameStr;

- (NSString *)viewFrame3;
- (void)setViewFrame3:(NSString *)frameStr;

- (NSString *)viewFrame4;
- (void)setViewFrame4:(NSString *)frameStr;

- (NSString *)nonTransformedViewFrame;
- (void)setNonTransformedViewFrame:(NSString *)frameStr;

- (NSNumber *)viewDistance1;
- (void)setViewDistance1:(NSNumber *)distance;

- (void)setViewFrameByOrig:(CGPoint const *)point;
- (void)setOrigYByAddOffset:(CGFloat)offsetY;
- (void)setOrigXByAddOffset:(CGFloat)offsetX;

- (void)changeFrameWidthToValue:(CGFloat)newWidth;
- (void)changeFrameHeightToValue:(CGFloat)newH;

- (void) fadeIn;
- (void) fadeOut;

@end

NS_ASSUME_NONNULL_END
