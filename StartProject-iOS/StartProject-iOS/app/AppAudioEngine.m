//
//  AppAudioEngine.m
//  XGame
//
//  Created by liulihua on 2017/12/21.
//  Copyright © 2017年 XGame. All rights reserved.
//

#import "AppAudioEngine.h"

static AppAudioEngine * __instance;
@implementation AppAudioEngine {
    AVAudioPlayer * _backgroundMusicPlayer;
    NSMutableArray *_soundPlayers;
}

+ (AppAudioEngine *)sharedEngine {
    if (__instance == nil) {
        @synchronized(self) {
            if (__instance == nil) {
                __instance = [[AppAudioEngine alloc] init];
            }
        }
    }
    return __instance;
}

+ (AppAudioEngine *)effectAudioEngine {
    return [AppAudioEngine sharedEngine];
}


+ (AppAudioEngine *)bgMusicEngine {
    return [AppAudioEngine sharedEngine];
}

- (id)init
{
    self = [super init];
    if (self) {
        _soundPlayers = [NSMutableArray arrayWithCapacity:8];
    }
    return self;
}

- (void)playEffect:(NSString*)filePath {
    
    filePath = [[NSBundle mainBundle] pathForResource:filePath ofType:nil];
    
    AVAudioPlayer * player = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];
    player.delegate = self;
    player.volume = self.effectVolume/100.f;
    [player play];
    if (player) {
        [_soundPlayers addObject:player];
    }
}

- (void)playBackgroundMusic:(NSString*)filePath loop:(BOOL) loop {
    filePath = [[NSBundle mainBundle] pathForResource:filePath ofType:nil];
    if (_backgroundMusicPlayer.isPlaying
        && [[_backgroundMusicPlayer.url absoluteString] hasSuffix:filePath]
        && (loop ? -1 : 0) == _backgroundMusicPlayer.numberOfLoops ) {
        return;
    }
    if (_backgroundMusicPlayer) {
        [_backgroundMusicPlayer stop];
    }
    _backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];
    if (loop) {
        _backgroundMusicPlayer.numberOfLoops = -1;
    }
    _backgroundMusicPlayer.volume = self.musicVolume/100.f;
    [_backgroundMusicPlayer play];
}

- (void)stopBackgroundMusic {
    
    if (_backgroundMusicPlayer) {
        [_backgroundMusicPlayer stop];
    }
}

- (void)stopEffectByName:(NSString *)effectName {
    
    NSArray * players = [NSArray arrayWithArray:_soundPlayers];
    for (AVAudioPlayer * player in players) {
        if([[player.url absoluteString] hasSuffix:effectName]) {
            [player stop];
            [_soundPlayers removeObject:player];
            break;
        }
    }
}

- (void)stopAllSoundAudio {
    
    NSArray * players = [NSArray arrayWithArray:_soundPlayers];
    for (AVAudioPlayer * player in players) {
        [player stop];
        [_soundPlayers removeObject:player];
    }
}

+ (void)stopAllSoundAudio {
    
    [[self sharedEngine] stopAllSoundAudio];
}

+ (void)stopBackgroundMusic {
    
    [[self sharedEngine] stopBackgroundMusic];
}

+ (void)playVibration {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark -
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [_soundPlayers removeObject:player];
}

@end


