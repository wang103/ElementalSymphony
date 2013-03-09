//
//  Elemental_SymphonyOptionViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 6/12/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyAppDelegate.h"
#import "Elemental_SymphonyOptionViewController.h"
#import "AVPlaybackSoundController.h"
#import "GameUtils.h"
#import "UserInformation.h"

@implementation Elemental_SymphonyOptionViewController

@synthesize volumeSlider;
@synthesize backToMainButton;
@synthesize setMusicButton;
@synthesize backToMapButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Set the button images.
	
	UIImage *goBackImageNormal = [UIImage imageNamed:@"ES_GameOptions_Button_Back.png"];
	[backToMapButton setBackgroundImage:goBackImageNormal forState:UIControlStateNormal];
	
	UIImage *goBackImagePressed = [UIImage imageNamed:@"ES_GameOptions_Button_Back_Press.png"];
	[backToMapButton setBackgroundImage:goBackImagePressed forState:UIControlStateHighlighted];
	
	UIImage *goBackToMainImageNormal = [UIImage imageNamed:@"ES_GameOptions_BacktoMain.png"];
	[backToMainButton setBackgroundImage:goBackToMainImageNormal forState:UIControlStateNormal];
	
	UIImage *goBackToMainImagePressed = [UIImage imageNamed:@"ES_GameOptions_BacktoMain_Press.png"];
	[backToMainButton setBackgroundImage:goBackToMainImagePressed forState:UIControlStateHighlighted];
	
	UIImage *setMusicNormal = [UIImage imageNamed:@"ES_GameOptions_Setmusic.png"];
	[setMusicButton setBackgroundImage:setMusicNormal forState:UIControlStateNormal];
	
	UIImage *setMusicPressed = [UIImage imageNamed:@"ES_GameOptions_Setmusic_Press.png"];
	[setMusicButton setBackgroundImage:setMusicPressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	UserInformation *UInfo = [UserInformation sharedManager];
	volumeSlider.value = UInfo.volume;
	
	shouldSave = NO;
	
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	if (shouldSave)
	{
		[GameUtils saveTheGame];
	}
	
	[super viewWillDisappear:animated];
}

// Switch the view to the main view (the initial one).
- (IBAction)switchViewToMainView:(id)sender
{
	UIViewController *root = self;
	while (root.parentViewController != nil)
	{
		root = root.parentViewController;
	}
	
	[root dismissModalViewControllerAnimated:YES];
}

// Switch view back to the map.
- (IBAction)switchViewToGoback:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (AVPlaybackSoundController *)theBGMObject
{
	id theDelegate = [UIApplication sharedApplication].delegate;
	AVPlaybackSoundController *theBGMController;
	theBGMController = ((Elemental_SymphonyAppDelegate *)theDelegate).avPlaybackSoundController;
	return theBGMController;
}

// Change Volume.
- (IBAction)changeSlider:(id)sender
{
	shouldSave = YES;
	
	float volume = volumeSlider.value;
	
	UserInformation *UInfo = [UserInformation sharedManager];
	UInfo.volume = volume;
	
	AVPlaybackSoundController *BGMController = [self theBGMObject];
	[BGMController setVolume:volume];
}

- (IBAction)switchViewToSetMusic:(id)sender
{
	// TODO: there should be no such method.
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
	
	self.volumeSlider = nil;
	self.backToMainButton = nil;
	self.setMusicButton = nil;
	self.backToMapButton = nil;
}

- (void)dealloc 
{
	[volumeSlider release];
	[backToMainButton release];
	[setMusicButton release];
	[backToMapButton release];
	
    [super dealloc];
}

@end
