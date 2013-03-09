//
//  AVPlaybackSoundController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/7/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "AVPlaybackSoundController.h"
#import "UserInformation.h"

@implementation AVPlaybackSoundController

@synthesize bgmPlayer;

// Set up audio session.
- (void)initAudioSession
{
	NSError *audioSessionError = nil;
	BOOL isSuccess = YES;
	
	// Set category.
	isSuccess = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:&audioSessionError];
	
	if (!isSuccess || audioSessionError)
	{
		NSLog(@"Error setting Audio Session category: %@", [audioSessionError localizedDescription]);
	}
	
	// Make this class the deletegate so it gets interrupts.
	[[AVAudioSession sharedInstance] setDelegate:self];
	
	audioSessionError = nil;
	// Activate the audio session.
	isSuccess = [[AVAudioSession sharedInstance] setActive:YES error:&audioSessionError];
	
	if (!isSuccess || audioSessionError)
	{
		NSLog(@"Error setting Audio Session active: %@", [audioSessionError localizedDescription]);
	}
}

// Initialize the music player to play the main theme song.
- (void)initBackgroundMusicPlayer
{
	UserInformation *UInfo = [UserInformation sharedManager];

	NSError *fileError = nil;
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle]
														 pathForResource:@"main" ofType:@"mp3"] 
											isDirectory:NO];
	bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&fileError];
	
	if (!fileURL || fileError)
	{
		NSLog(@"Error loading music file: %@", [fileError localizedDescription]);
	}
	
	self.bgmPlayer.delegate = self;
	self.bgmPlayer.numberOfLoops = -1;		// Loop forever.
	self.bgmPlayer.volume = UInfo.volume;
	
	[fileURL release];
}

/*
 * 0 - main music.
 * 1 - earth theme music.
 *
 * Will not start playing upon return.
 */
- (void)switchBackgroundMusic:(int)musicNumber
{
	if (self.bgmPlayer.isPlaying)
	{
		[self.bgmPlayer stop];		
	}
	
	[bgmPlayer release];
	
	NSString *fileName;
	switch (musicNumber)
	{
		case 0:
			fileName = [NSString stringWithString:@"main_theme"];
			break;
		case 1:
			fileName = [NSString stringWithString:@"earth_theme"];
		default:
			break;
	}
	
	NSError *fileError = nil;
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle]
														 pathForResource:fileName ofType:@"m4a"] 
											isDirectory:NO];
	bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&fileError];
	
	if (!fileURL || fileError)
	{
		NSLog(@"Error loading music file: %@", [fileError localizedDescription]);
	}
	
	UserInformation *UInfo = [UserInformation sharedManager];

	self.bgmPlayer.delegate = self;
	self.bgmPlayer.numberOfLoops = -1;	// Loop forever.
	self.bgmPlayer.volume = UInfo.volume;

	[self.bgmPlayer prepareToPlay];
	
	[fileURL release];	
}

// Set music volume.
- (void)setVolume:(float)newVolume
{
	self.bgmPlayer.volume = newVolume;
}

// Initialization (music will start to play).
- (AVPlaybackSoundController *)init
{
	[self initAudioSession];
	[self initBackgroundMusicPlayer];
	
	[self.bgmPlayer play];
	
	return [super init];
}

- (void)pausePlayer
{
	if (self.bgmPlayer.playing)
	{
		[self.bgmPlayer pause];
	}
}

- (void)stopPlayer
{
	if (self.bgmPlayer.playing)
	{
		[self.bgmPlayer stop];
	}
}

- (void)startPlayer
{
	if ( !self.bgmPlayer.playing)
	{
		[self.bgmPlayer play];
	}
}

// Rewind to the top, assume it's playing.
- (void)playFromTop
{
	[self stopPlayer];
	self.bgmPlayer.currentTime = 0.0;
	[self startPlayer];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
	[player play];
}

- (void)dealloc
{
	[bgmPlayer release];
	
	[super dealloc];
}

@end
