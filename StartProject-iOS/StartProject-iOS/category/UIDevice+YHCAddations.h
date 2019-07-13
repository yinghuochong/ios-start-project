//
//  UIDevice+YHCAddations.h
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (YHCAddations)
+ (CGFloat)mainScreenScale;
+ (CGFloat)deviceOSVersion;
- (NSArray *)runningProcesses;

+ (NSTimeZone *)serverTimeZone;
+ (NSString*)getMachineName;
+ (NSString *)deviceIPAdress;

+ (BOOL)isIphoneX;
+ (CGFloat)bottmHeight;

@end

NS_ASSUME_NONNULL_END
