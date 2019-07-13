//
//  NSData+YHCBase64.h
//  StartProject-iOS
//
//  Created by liulihua on 2019/7/13.
//  Copyright © 2019 萤火虫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void *NewBase64Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *NewBase64Encode(
                      const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);

@interface NSData (YHCBase64)

+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)base64EncodedString;

@end

NS_ASSUME_NONNULL_END
