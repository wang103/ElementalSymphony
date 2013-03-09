//
//  Elemental_SymphonyGameMenuViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 6/13/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyAppDelegate.h"
#import "Elemental_SymphonyGameMenuViewController.h"
#import "AVPlaybackSoundController.h"
#import "UserInformation.h"
#import "GameUtils.h"

@implementation Elemental_SymphonyGameMenuViewController

@synthesize soundButton;
@synthesize resumeButton;
@synthesize restartButton;
@synthesize quitGameButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Set the button images.
	
	UIImage *resumeNormal = [UIImage imageNamed:@"ES_GameMenu_Resume.png"];
	[resumeButton setBackgroundImage:resumeNormal forState:UIControlStateNormal];
	
	UIImage *resumePressed = [UIImage imageNamed:@"ES_GameMenu_Resume_press.png"];
	[resumeButton setBackgroundImage:resumePressed forState:UIControlStateHighlighted];
	
	UIImage *restartNormal = [UIImage imageNamed:@"ES_GameMenu_Restart.png"];
	[restartButton setBackgroundImage:restartNormal forState:UIControlStateNormal];
	
	UIImage *restartPressed = [UIImage imageNamed:@"ES_GameMenu_Restart_press.png"];
	[restartButton setBackgroundImage:restartPressed forState:UIControlStateHighlighted];
	
	UIImage *quitNormal = [UIImage imageNamed:@"ES_GameMenu_Quitgame.png"];
	[quitGameButton setBackgroundImage:quitNormal forState:UIControlStateNormal];
	
	UIImage *quitPressed = [UIImage imageNamed:@"ES_GameMenu_Quitgame_press.png"];
	[quitGameButton setBackgroundImage:quitPressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	UserInformation *UInfo = [UserInformation sharedManager];
	
	UIImage *soundImage;
	
	if(UInfo.isSoundOn)
	{
		soundImage = [UIImage imageNamed:@"ES_GameMenu_soundon.png"];
	}
	else 
	{
		soundImage = [UIImage imageNamed:@"ES_GameMenu_soundoff.png"];
	}
	
	[soundButton setImage:soundImage forState:UIControlStateNormal];
	
	[super viewWillAppear:animated];
}

- (AVPlaybackSoundController *)theBGMObject
{
	id theDelegate = [UIApplication sharedApplication].delegate;
	AVPlaybackSoundController *theBGMController;
	theBGMController = ((Elemental_SymphonyAppDelegate *)theDelegate).avPlaybackSoundController;
	return theBGMController;
}

// Swith sound On/Off.
- (IBAction)pressedSoundButton:(id)sender
{
	UserInformation *UInfo = [UserInformation sharedManager];
	
	AVPlaybackSoundController *BGMController = [self theBGMObject];
	
	UIImage *soundImage;
	if(UInfo.isSoundOn)
	{
		UInfo.isSoundOn = NO;
		soundImage = [UIImage imageNamed:@"ES_GameMenu_soundoff.png"];
		
		[BGMController pausePlayer];
	}
	else
	{
		UInfo.isSoundOn = YES;
		soundImage = [UIImage imageNamed:@"ES_GameMenu_soundon.png"];
		
		[BGMController startPlayer];
	}
	
	[soundButton setImage:soundImage forState:UIControlStateNormal];
}

// Restart the current game.
- (IBAction)pressedRestartButton:(id)sender
{
	UIActionSheet *actionSheetForRestart = [[UIActionSheet alloc]
								  initWithTitle:@"Do you want to restart this round?"
								  delegate:self
								  cancelButtonTitle:@"No" 
								  destructiveButtonTitle:@"Yes"
								  otherButtonTitles:nil];
	
	[actionSheetForRestart showInView:self.view];
	[actionSheetForRestart release];
}

// Quit the current game (go back to main view).
- (IBAction)pressedQuitButton:(id)sender
{
	UIActionSheet *actionSheetForQuit = [[UIActionSheet alloc]
											initWithTitle:@"Do you want to quit the current game?"
											delegate:self
											cancelButtonTitle:@"No" 
											destructiveButtonTitle:@"Yes"
											otherButtonTitles:nil];
	[actionSheetForQuit showInView:self.view];
	[actionSheetForQuit release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if([actionSheet.title isEqualToString:@"Do you want to restart this round?"])
	{
		if (buttonIndex != [actionSheet cancelButtonIndex])
		{
			[GameUtils setShouldRestartGame:YES];
			
			[self switchViewBackToGame:nil];
		}
	}
	else if([actionSheet.title isEqualToString:@"Do you want to quit the current game?"])
	{
		if(buttonIndex != [actionSheet cancelButtonIndex])
		{
			[GameUtils setShouldQuitGame:YES];
			
			[self switchViewBackToGameWithNoAnimation];
		}
	}
}

// Switch view back to the game without animation.
- (void)switchViewBackToGameWithNoAnimation
{
	[GameUtils setJustQuittedFromGameMenu:YES];

	[self.parentViewController dismissModalViewControllerAnimated:NO];
}

// Switch view back to the game.
- (IBAction)switchViewBackToGame:(id)sender
{
	[GameUtils setJustQuittedFromGameMenu:YES];
	
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.soundButton = nil;
	self.resumeButton = nil;
	self.restartButton = nil;
	self.quitGameButton = nil;
}

- (void)dealloc 
{
	[soundButton release];
	[resumeButton release];
	[restartButton release];
	[quitGameButton release];
	
    [super dealloc];
}

@end
