//
//  AVPlaybackSoundController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/7/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface AVPlaybackSoundController : NSObject <AVAudioSessionDelegate, AVAudioPlayerDelegate>
{
	AVAudioPlayer *bgmPlayer;
}

@property (nonatomic, retain) AVAudioPlayer *bgmPlayer;

- (void)initAudioSession;
- (void)initBackgroundMusicPlayer;

- (void)setVolume:(float)newVolume;
- (void)switchBackgroundMusic:(int)musicNumber;
- (void)pausePlayer;
- (void)stopPlayer;
- (void)startPlayer;
- (void)playFromTop;

@end
