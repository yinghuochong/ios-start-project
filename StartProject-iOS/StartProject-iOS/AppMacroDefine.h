//
//  AppMacroDefine.h
//  StartProject-iOS
//
//  Created by firefly on 2019/7/10.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#ifndef AppMacroDefine_h
#define AppMacroDefine_h





#warning todo
//设备类型判断
//是否是留海屏
//将像素转换成点的宏
//iphoneX系列底部安全区域
//状态栏高度，需要考虑iPhoneX 和 来电话的情况


#define WEAKSELF __block __typeof(&*self)weakSelf = self;

/**
 * 解决循环引用的问题 ：@weakify(self), @strongify(self)
 示例:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 */

#ifndef weakify
    #if TARGET_IPHONE_DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if TARGET_IPHONE_DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif




#endif /* AppMacroDefine_h */
