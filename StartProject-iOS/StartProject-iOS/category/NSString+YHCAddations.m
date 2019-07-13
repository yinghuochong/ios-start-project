//
//  NSString+YHCAddations.m
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import "NSString+YHCAddations.h"

@implementation NSString (YHCAddations)

+ (NSString *)stringFromInteger:(NSInteger)num {
    return [NSString stringWithFormat:@"%ld", (long)num];
}

+ (NSString *)stringFromInt64:(int64_t)num {
    
    return [NSString stringWithFormat:@"%lld", num];
}

+ (NSString *)unquiueKeyForObject:(id<NSObject>)obj {
    
    return [NSString stringWithFormat:@"<%@: %p>", [obj class], obj];
}

+ (NSString *)niceFormatForMoney:(int64_t)money {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setMaximumFractionDigits:12];
    
    NSNumber *num = [NSNumber numberWithLongLong:money];
    return [numberFormatter stringFromNumber:num];
}

+ (NSData*)bytesFromHexString:(NSString *)aString {
    
    NSString *theString = [[aString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
    
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= theString.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [theString substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        if ([scanner scanHexInt:&intValue])
            [data appendBytes:&intValue length:1];
    }
    return data;
}

- (NSString *)stringByTrimmingSpacesCharacters {
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSInteger)numOfCharsCaclForApp {
    
    NSInteger len = [self length];
    NSArray *comps = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithRange:NSMakeRange(0, 255)]];
    
    NSString *nonASCIIChars = [comps componentsJoinedByString:@""];
    NSInteger len2 = [nonASCIIChars length];
    len = len2 + ceil((len - len2) * .5);
    return len;
}

- (NSString *)stringValue {
    return self;
}
- (BOOL)isAllNumeral{
    const char *s = [self UTF8String];
    for (size_t i=0;i<strlen(s);i++)
    {
        if (s[i]<'0' || s[i]>'9')
        {
            return NO;
        }
    }
    return YES;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    //  // Encode all the reserved characters, per RFC 3986
    //  // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

+ (NSInteger)indexOfString:(NSString *)str width:(float)maxWidth font:(UIFont *)font{
    NSString *oldStr = str;
    NSString *newStr = oldStr;
    
    for (NSInteger i = oldStr.length-1; i >= 0 ; i--) {
        newStr = [oldStr substringToIndex:i];
        CGSize size = [newStr sizeWithAttributes:@{NSFontAttributeName : font}];
        if (size.width <= maxWidth) {
            return i;
        }
    }
    return newStr.length-1;
}
+ (NSString *)timeString:(NSInteger)interval{
    NSInteger second = interval % 60;
    NSInteger minute = (interval/60)%60;
    NSInteger hour = interval/3600;
    NSString *str = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,minute,second];
    return str;
}


@end
