//
//  EncryptUtils.h
//  XGame
//
//  Created by liulihua on 2017/12/31.
//  Copyright © 2017年 XGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptUtils : NSObject

//md5方法
+ (NSString *) md5String:(NSString *) input;
+(NSString *) md5Data:(NSData * )data;
//十六进制字符串和data之间转换
+(NSString *) convertDataToHexStr:(NSData *)data;
+(NSData *) convertHexStrToData:(NSString *)str;

@end
