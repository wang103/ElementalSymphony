//
//  Elemental_SymphonyGameMenuViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 6/13/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlaybackSoundController;

@interface Elemental_SymphonyGameMenuViewController : UIViewController <UIActionSheetDelegate>
{
	UIButton *soundButton;
	UIButton *resumeButton;
	UIButton *restartButton;
	UIButton *quitGameButton;
}

@property (nonatomic, retain) IBOutlet UIButton *soundButton;
@property (nonatomic, retain) IBOutlet UIButton *resumeButton;
@property (nonatomic, retain) IBOutlet UIButton *restartButton;
@property (nonatomic, retain) IBOutlet UIButton *quitGameButton;

- (AVPlaybackSoundController *)theBGMObject;
- (IBAction)pressedSoundButton:(id)sender;
- (IBAction)switchViewBackToGame:(id)sender;
- (IBAction)pressedRestartButton:(id)sender;
- (IBAction)pressedQuitButton:(id)sender;

- (void)switchViewBackToGameWithNoAnimation;

@end
