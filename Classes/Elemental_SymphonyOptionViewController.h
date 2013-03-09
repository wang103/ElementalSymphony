//
//  Elemental_SymphonyOptionViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 6/12/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlaybackSoundController;

@interface Elemental_SymphonyOptionViewController : UIViewController 
{
	BOOL shouldSave;
	
	UISlider *volumeSlider;
	UIButton *backToMainButton;
	UIButton *setMusicButton;
	UIButton *backToMapButton;
}

@property (nonatomic, retain) IBOutlet UISlider *volumeSlider;
@property (nonatomic, retain) IBOutlet UIButton *backToMainButton;
@property (nonatomic, retain) IBOutlet UIButton *setMusicButton;
@property (nonatomic, retain) IBOutlet UIButton *backToMapButton;

- (IBAction)switchViewToMainView:(id)sender;
- (IBAction)switchViewToGoback:(id)sender;
- (IBAction)switchViewToSetMusic:(id)sender;

- (AVPlaybackSoundController *)theBGMObject;
- (IBAction)changeSlider:(id)sender;

@end
