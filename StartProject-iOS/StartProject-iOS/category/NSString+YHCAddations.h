//
//  NSString+YHCAddations.h
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YHCAddations)

+ (NSString *)stringFromInteger:(NSInteger)num;
+ (NSString *)stringFromInt64:(int64_t)num;
+ (NSData*)bytesFromHexString:(NSString *)aString;
+ (NSString *)unquiueKeyForObject:(id)obj;
- (NSString *)stringByTrimmingSpacesCharacters;
+ (NSString *)niceFormatForMoney:(int64_t)money;

- (NSInteger)numOfCharsCaclForApp;

- (NSString *)stringValue;
- (BOOL)isAllNumeral;

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;
//获取font字体的字符串 在maxWidth的index
+ (NSInteger)indexOfString:(NSString *)str
                     width:(float)maxWidth
                      font:(UIFont *)font;
// 06:30:59
+ (NSString *)timeString:(NSInteger)interval;
@end

NS_ASSUME_NONNULL_END
