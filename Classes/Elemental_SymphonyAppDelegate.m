//
//  Elemental_SymphonyAppDelegate.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/17/10.
//  Copyright University of Illinois at Urbana-Champaign 2010. All rights reserved.
//

#import "Elemental_SymphonyAppDelegate.h"
#import "Elemental_SymphonyMainViewController.h"
#import "UserInformation.h"
#import "AVPlaybackSoundController.h"

@implementation Elemental_SymphonyAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize avPlaybackSoundController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{        
    // Override point for customization after app launch
	
	// Hide the status bar.
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
	[window addSubview:viewController.view];
    
	[window makeKeyAndVisible];
	
	return YES;
}

- (id)init
{
	self.avPlaybackSoundController = [[AVPlaybackSoundController alloc] init];
	[avPlaybackSoundController release];
	
	return [super init];
}

- (void)dealloc 
{
    [viewController release];
    [window release];
	[avPlaybackSoundController release];
	
    [super dealloc];
}

@end
