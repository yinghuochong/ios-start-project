//
//  UIDevice+IdentifierAddition.m
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import "UIDevice+IdentifierAddition.h"
#import "SSKeychain.h"

@implementation UIDevice (IdentifierAddition)

//将 生成的uuid保存再 keychain里 随时可以读取之
- (NSString *)appDeviceUUID{
    NSString *key = [[NSBundle mainBundle] bundleIdentifier];
    NSString *retrieveuuid = [SSKeychain passwordForService:key account:@"deviceID"];
    if (retrieveuuid == nil) {
        // Create a new UUID
        CFUUIDRef uuidObj = CFUUIDCreate(nil);
        // Get the string representation of the UUID
        NSString *newUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
        CFRelease(uuidObj);
        
        NSString *idStr = newUUID;
        idStr = [idStr stringByReplacingOccurrencesOfString:@"-" withString:@""];//
        [SSKeychain setPassword:idStr forService:key account:@"deviceID"];
        retrieveuuid = [SSKeychain passwordForService:key account:@"deviceID"];
    }
    return retrieveuuid;
}

@end
