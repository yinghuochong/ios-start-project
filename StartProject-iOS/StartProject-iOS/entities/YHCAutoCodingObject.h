//
//  YHCAutoCodingObject.h
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHCAutoCodingObject : NSObject

+ (NSData *)archiveObject:(id<NSCoding>)obj;
+ (id)unarchiveObjectFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
