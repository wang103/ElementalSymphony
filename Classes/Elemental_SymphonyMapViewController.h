//
//  Elemental_SymphonyMapViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Elemental_SymphonyStatusViewController;
@class Elemental_SymphonyOptionViewController;
@class UnitUpgradeViewController;
@class Elemental_SymphonyBeforeGameViewController;
@class Elemental_SymphonyInfoViewController;
@class AVPlaybackSoundController;

@interface Elemental_SymphonyMapViewController : UIViewController
{
	UIButton *statusButton;		// The button to see player's status.
	UIButton *unitsButton;		// The button to see player's units.
	UIButton *infosButton;		// The button to see player's information.
	UIButton *optionsButton;	// The button to see the game options.
	
	UIButton *stageButtons[21];
	
	Elemental_SymphonyStatusViewController *statusViewController;
	Elemental_SymphonyOptionViewController *optionViewController;
	UnitUpgradeViewController *unitUpgradeViewController;
	Elemental_SymphonyBeforeGameViewController *beforeGameViewController;
	Elemental_SymphonyInfoViewController *infoViewController;
}

@property (nonatomic, retain) IBOutlet UIButton *statusButton;
@property (nonatomic, retain) IBOutlet UIButton *unitsButton;
@property (nonatomic, retain) IBOutlet UIButton *infosButton;
@property (nonatomic, retain) IBOutlet UIButton *optionsButton;

@property (nonatomic, retain) Elemental_SymphonyStatusViewController *statusViewController;
@property (nonatomic, retain) Elemental_SymphonyOptionViewController *optionViewController;
@property (nonatomic, retain) UnitUpgradeViewController *unitUpgradeViewController;
@property (nonatomic, retain) Elemental_SymphonyBeforeGameViewController *beforeGameViewController;
@property (nonatomic, retain) Elemental_SymphonyInfoViewController *infoViewController;


- (IBAction)switchViewToSeeStatus:(id)sender;
- (IBAction)switchViewToGame:(id)sender;
- (IBAction)switchViewToOption:(id)sender;
- (IBAction)switchViewToUnit:(id)sender;
- (IBAction)switchViewToInfo:(id)sender;
- (void)initializeMapStageButtons;

- (AVPlaybackSoundController *)theBGMObject;

@end
