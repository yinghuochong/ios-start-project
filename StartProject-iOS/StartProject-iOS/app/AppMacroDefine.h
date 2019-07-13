//
//  AppMacroDefine.h
//  StartProject-iOS
//
//  Created by firefly on 2019/7/10.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#ifndef AppMacroDefine_h
#define AppMacroDefine_h



#pragma mark - Logging
///---------------------------------------------------------------------------
/// @name Logging Messages to the Console
///---------------------------------------------------------------------------

// FTLOGEXT logging macro from: http://iphoneincubator.com/blog/debugging/the-evolution-of-a-replacement-for-nslog
#ifdef DEBUG

/**
 A simple wrapper for `NSLog()` that is automatically removed from release builds.
 */
#define FTLOG(...) NSLog(__VA_ARGS__)

/**
 More detailed loogging. Logs the function name and line number after the log message.
 */
#define FTLOGEXT(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

/**
 Logs a method call's class and selector.
 */
#define FTLOGCALL FTLOG(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd))

#else
#define FTLOG(...) /* */
#define FTLOGEXT(...) /* */
#define FTLOGCALL /* */
#endif

#pragma mark - Memory Management
///---------------------------------------------------------------------------
/// @name Memory Management
///---------------------------------------------------------------------------

/**
 Safely release an objective-c object and set its variable to `nil`.
 */
#define FTRELEASE(_obj) [_obj release], _obj = nil

/**
 Safely free a pointer and set its variable to `NULL`.
 */
#define FTFREE(_ptr) if(_ptr != NULL) { free(_ptr); _ptr = NULL; }

#pragma mark - Math
///---------------------------------------------------------------------------
/// @name Math Helpers
///---------------------------------------------------------------------------

/** Convert from degrees to radians */
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

/** Convert from radians to degrees */
#define RADIANS_TO_DEGREES(r) (r * 180 / M_PI)

#pragma mark - Colors
///---------------------------------------------------------------------------
/// @name Creating colors
///---------------------------------------------------------------------------

/**
 Create a UIColor with r,g,b values between 0.0 and 1.0.
 */
#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:1.f]

/**
 Create a UIColor with r,g,b,a values between 0.0 and 1.0.
 */
#define RGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a]

/**
 Create a UIColor from a hex value.
 
 For example, `UIColorFromRGB(0xFF0000)` creates a `UIColor` object representing
 the color red.
 */
#define UIColorFromRGB(rgbValue) \
[UIColor \
    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
    blue:((float)(rgbValue & 0x0000FF))/255.0 \
    alpha:1.0]

/**
 Create a UIColor with an alpha value from a hex value.
 
 For example, `UIColorFromRGBA(0xFF0000, .5)` creates a `UIColor` object
 representing a half-transparent red.
 */
#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
    blue:((float)(rgbValue & 0x0000FF))/255.0 \
    alpha:alphaValue]

#pragma mark - Delegates
///---------------------------------------------------------------------------
/// @name Calling Delegates
///---------------------------------------------------------------------------

/**
 Call a delegate method if the selector exists.
 */
#define FT_CALL_DELEGATE(_delegate, _selector) \
do { \
    id _theDelegate = _delegate; \
    if(_theDelegate != nil && [_theDelegate respondsToSelector:_selector]) { \
        [_theDelegate performSelector:_selector]; \
    } \
} while(0);

/**
 Call a delegate method that accepts one argument if the selector exists.
 */
#define FT_CALL_DELEGATE_WITH_ARG(_delegate, _selector, _argument) \
do { \
    id _theDelegate = _delegate; \
    if(_theDelegate != nil && [_theDelegate respondsToSelector:_selector]) { \
        [_theDelegate performSelector:_selector withObject:_argument]; \
    } \
} while(0);

/**
 Call a delegate method that accepts two arguments if the selector exists.
 */
#define FT_CALL_DELEGATE_WITH_ARGS(_delegate, _selector, _arg1, _arg2) \
do { \
    id _theDelegate = _delegate; \
    if(_theDelegate != nil && [_theDelegate respondsToSelector:_selector]) { \
        [_theDelegate performSelector:_selector withObject:_arg1 withObject:_arg2]; \
    } \
} while(0);

#pragma mark - Device
///---------------------------------------------------------------------------
/// @name device releated
///---------------------------------------------------------------------------
//是否是留海屏
#define is_iPhoneXSerious @available(iOS 11.0, *) && UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom > 0.0
//是否是iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//顶部和底部高度
#define Height_topBar (isiPhoneX_All ? 83.0f:49.0f)
#define Height_BottomSafe (isiPhoneX_All? 34.0f:0.0f)

#pragma mark - GCD
///---------------------------------------------------------------------------
/// @name GCD call
///---------------------------------------------------------------------------

#define APP_DISPATCH_ON_MAIN_LATER(__seconds, __block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __seconds * NSEC_PER_SEC), dispatch_get_main_queue(), __block);



#pragma mark - circle retain
///---------------------------------------------------------------------------
/// @name circle retain releated
///---------------------------------------------------------------------------
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
