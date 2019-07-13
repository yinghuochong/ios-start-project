//
//  AppAudioEngine.h
//  XGame
//
//  Created by liulihua on 2017/12/21.
//  Copyright © 2017年 XGame. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface AppAudioEngine : NSObject <AVAudioPlayerDelegate>

@property(nonatomic,assign) NSInteger effectVolume;
@property(nonatomic,assign) NSInteger musicVolume;

+ (AppAudioEngine *)effectAudioEngine;
+ (AppAudioEngine *)bgMusicEngine;

- (void)playEffect:(NSString*)filePath;
- (void)playBackgroundMusic:(NSString*) filePath loop:(BOOL) loop;
- (void)stopBackgroundMusic;
- (void)stopEffectByName:(NSString *)effectName;
+ (void)stopAllSoundAudio;
+ (void)playVibration;

@end

