//
//  Elemental_SymphonyBeforeGameViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/1/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Elemental_SymphonyGameViewController;
@class AVPlaybackSoundController;

@interface Elemental_SymphonyBeforeGameViewController : UIViewController 
{
	UILabel *stageLabel;
	UIButton *continueButton;
	UIButton *goBackButton;
	UIImageView *fakeButtonImageView;
	
	Elemental_SymphonyGameViewController *gameViewController;
}

@property (nonatomic, retain) IBOutlet UILabel *stageLabel;
@property (nonatomic, retain) IBOutlet UIButton *continueButton;
@property (nonatomic, retain) IBOutlet UIButton *goBackButton;
@property (nonatomic, retain) Elemental_SymphonyGameViewController *gameViewController;

- (IBAction)switchViewToGame:(id)sender;
- (IBAction)switchViewBackToMap:(id)sender;
- (AVPlaybackSoundController *)theBGMObject;

@end
