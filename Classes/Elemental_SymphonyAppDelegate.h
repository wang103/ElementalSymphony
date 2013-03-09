//
//  Elemental_SymphonyAppDelegate.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/17/10.
//  Copyright University of Illinois at Urbana-Champaign 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Elemental_SymphonyMainViewController;
@class AVPlaybackSoundController;

@interface Elemental_SymphonyAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    Elemental_SymphonyMainViewController *viewController;
	AVPlaybackSoundController *avPlaybackSoundController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Elemental_SymphonyMainViewController *viewController;
@property (nonatomic, retain) AVPlaybackSoundController *avPlaybackSoundController;

@end

