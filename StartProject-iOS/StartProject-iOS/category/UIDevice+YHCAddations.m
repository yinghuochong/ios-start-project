//
//  UIDevice+YHCAddations.m
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import "UIDevice+YHCAddations.h"
#import "GetIPAddress.h"
#import <sys/sysctl.h>

@implementation UIDevice (YHCAddations)

+ (CGFloat)mainScreenScale {
    
    static CGFloat scale = -1.f;
    if (scale < 0.f) {
        scale = [UIScreen mainScreen].scale;
    }
    return scale;
}

+ (CGFloat)deviceOSVersion {
    static CGFloat version = 0.f;
    if (version < 1.f) {
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    return version;
}

- (NSArray *)runningProcesses {
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    
    size_t size;
    int st = sysctl(mib, (u_int)miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess){
            
            if (process){
                free(process);
            }
            
            return nil;
        }
        
        process = newprocess;
        st = sysctl(mib, (u_int)miblen, process, &size, NULL, 0);
        
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = (int)(size / sizeof(struct kinfo_proc));
            
            if (nprocess){
                
                NSMutableArray * array = [[NSMutableArray alloc] init];
                
                for (int i = nprocess - 1; i >= 0; i--){
                    
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil]
                                                                        forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];
                    [array addObject:dict];
                }
                
                free(process);
                return array;
            }
        }
    }
    if (process != NULL) {
        free(process);
    }
    return nil;
}

+ (NSTimeZone *)serverTimeZone {
    static NSTimeZone * tz = nil;
    if (tz == nil) {
        tz = [NSTimeZone timeZoneForSecondsFromGMT:(8 * 86400)];
    }
    return tz;
}

+ (NSString*)getMachineName{
    return [[UIDevice currentDevice] name];
}
#pragma mark -  getIP

+ (NSString *)deviceIPAdress {
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();
    return [NSString stringWithFormat:@"%s", ip_names[1]];
}

+ (BOOL)isIphoneX {
    BOOL isIphoneX = NO;
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            isIphoneX = YES;
        }
    }
    return isIphoneX;
}

+ (CGFloat)bottmHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        return mainWindow.safeAreaInsets.bottom;
    }
    return 0;
}


@end
