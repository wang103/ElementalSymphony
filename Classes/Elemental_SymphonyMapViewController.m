//
//  Elemental_SymphonyMapViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyMapViewController.h"
#import "Elemental_SymphonyStatusViewController.h"
#import "Elemental_SymphonyOptionViewController.h"
#import "UnitUpgradeViewController.h"
#import "Elemental_SymphonyBeforeGameViewController.h"
#import "Elemental_SymphonyInfoViewController.h"
#import "AVPlaybackSoundController.h"
#import "Elemental_SymphonyAppDelegate.h"
#import "UserInformation.h"
#import "GameUtils.h"

@implementation Elemental_SymphonyMapViewController

@synthesize statusButton;
@synthesize unitsButton;
@synthesize infosButton;
@synthesize optionsButton;
@synthesize statusViewController;
@synthesize optionViewController;
@synthesize unitUpgradeViewController;
@synthesize beforeGameViewController;
@synthesize infoViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Set up button images.
	
	UIImage *statusButtonNormal = [UIImage imageNamed:@"ES_Button_Status.png"];
	[statusButton setBackgroundImage:statusButtonNormal forState:UIControlStateNormal];
	
	UIImage *statusButtonPressed = [UIImage imageNamed:@"ES_Button_Status_Press.png"];
	[statusButton setBackgroundImage:statusButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *unitsButtonNormal = [UIImage imageNamed:@"ES_Button_Units.png"];
	[unitsButton setBackgroundImage:unitsButtonNormal forState:UIControlStateNormal];
	
	UIImage *unitsButtonPressed = [UIImage imageNamed:@"ES_Button_Units_Press.png"];
	[unitsButton setBackgroundImage:unitsButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *infosButtonNormal = [UIImage imageNamed:@"ES_Button_Infos.png"];
	[infosButton setBackgroundImage:infosButtonNormal forState:UIControlStateNormal];
	
	UIImage *infosButtonPressed = [UIImage imageNamed:@"ES_Button_Infos_Press.png"];
	[infosButton setBackgroundImage:infosButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *optionsButtonNormal = [UIImage imageNamed:@"ES_Button_Options.png"];
	[optionsButton setBackgroundImage:optionsButtonNormal forState:UIControlStateNormal];
	
	UIImage *optionsButtonsPressed = [UIImage imageNamed:@"ES_Button_Options_Press.png"];
	[optionsButton setBackgroundImage:optionsButtonsPressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)initializeMapStageButtons
{
	// Read user's information, set up the stage buttons.
	UserInformation *UInfo = [UserInformation sharedManager];
	
	for (int i = 0; i < 21; ++i)
	{
		// Create a custom button.
		stageButtons[i] = [UIButton buttonWithType:UIButtonTypeCustom];
		[stageButtons[i] retain];
		
		UIImage *bossImageOpen = [UIImage imageNamed:@"ES_BossStage_Open.png"];
		UIImage *bossImageClear = [UIImage imageNamed:@"ES_BossStage_Clear.png"];
		UIImage *smallImageOpen = [UIImage imageNamed:@"ES_SmallStage_Open.png"];
		UIImage *smallImageClear = [UIImage imageNamed:@"ES_SmallStage_Clear.png"];
		
		BOOL shouldAppear = YES;
		
		if (i == 4 || i == 9 || i == 14 || i == 19 || i == 20)	// Boss stages.
		{
			if([UInfo passedStages:i])
			{
				[stageButtons[i] setBackgroundImage:bossImageClear forState:UIControlStateNormal];
				stageButtons[i].enabled = NO;
			}
			else
			{
				[stageButtons[i] setBackgroundImage:bossImageOpen forState:UIControlStateNormal];
				stageButtons[i].enabled = YES;
			}
			
			if (i == 4 || i == 9 || i == 14 || i == 19)
			{
				for (int counter = i - 1; counter >= i - 4; counter --) 
				{
					if ([UInfo passedStages:counter] == NO)
					{
						shouldAppear = NO;
						break;
					}
				}
			}
			else 
			{
				if ([UInfo passedStages:4] == NO || [UInfo passedStages:9] == NO || 
					[UInfo passedStages:14] == NO || [UInfo passedStages:19] == NO)
				{
					shouldAppear = NO;
				}
			}
		}
		else													// Regular stages.
		{
			if([UInfo passedStages:i])
			{
				[stageButtons[i] setBackgroundImage:smallImageClear forState:UIControlStateNormal];
				stageButtons[i].enabled = NO;
			}
			else
			{
				[stageButtons[i] setBackgroundImage:smallImageOpen forState:UIControlStateNormal];
				stageButtons[i].enabled = YES;
			}
			
			if (i == 5 || i == 6 || i == 7 || i == 8)
			{
				if ([UInfo passedStages:4] == NO)
				{
					shouldAppear = NO;
				}
			}
			if (i == 10 || i == 11 || i == 12 || i == 13)
			{
				if ([UInfo passedStages:9] == NO)
				{
					shouldAppear = NO;
				}
			}
			if (i == 15 || i == 16 || i == 17 || i == 18)
			{
				if ([UInfo passedStages:14] == NO)
				{
					shouldAppear = NO;
				}
			}
		}
		
		if (shouldAppear == NO)
		{
			continue;
		}
		
		// Set the button's size and location.
		switch (i) 
		{
			case 0:
				stageButtons[i].frame = CGRectMake(70.0, 299.0, 30.0, 30.0);
				break;
			case 1:
				stageButtons[i].frame = CGRectMake(23.0, 240.0, 30.0, 30.0);
				break;
			case 2:
				stageButtons[i].frame = CGRectMake(28.0, 198.0, 30.0, 30.0);
				break;
			case 3:
				stageButtons[i].frame = CGRectMake(76.0, 243.0, 30.0, 30.0);
				break;
			case 4:
				stageButtons[i].frame = CGRectMake(140.0, 265.0, 30.0, 30.0);
				break;
			case 5:
				stageButtons[i].frame = CGRectMake(183.0, 217.0, 30.0, 30.0);
				break;
			case 6:
				stageButtons[i].frame = CGRectMake(112.0, 212.0, 30.0, 30.0);
				break;
			case 7:
				stageButtons[i].frame = CGRectMake(272.0, 188.0, 30.0, 30.0);
				break;
			case 8:
				stageButtons[i].frame = CGRectMake(223.0, 140.0, 30.0, 30.0);
				break;
			case 9:
				stageButtons[i].frame = CGRectMake(182.0, 179.0, 30.0, 30.0);
				break;
			case 10:
				stageButtons[i].frame = CGRectMake(146.0, 148.0, 30.0, 30.0);
				break;
			case 11:
				stageButtons[i].frame = CGRectMake(220.0, 96.0, 30.0, 30.0);
				break;
			case 12:
				stageButtons[i].frame = CGRectMake(156.0, 82.0, 30.0, 30.0);
				break;
			case 13:
				stageButtons[i].frame = CGRectMake(97.0, 120.0, 30.0, 30.0);
				break;
			case 14:
				stageButtons[i].frame = CGRectMake(45.0, 131.0, 30.0, 30.0);
				break;
			case 15:
				stageButtons[i].frame = CGRectMake(43.0, 83.0, 30.0, 30.0);
				break;
			case 16:
				stageButtons[i].frame = CGRectMake(60.0, 11.0, 30.0, 30.0);
				break;
			case 17:
				stageButtons[i].frame = CGRectMake(98.0, 52.0, 30.0, 30.0);
				break;
			case 18:
				stageButtons[i].frame = CGRectMake(169.0, 32.0, 30.0, 30.0);
				break;
			case 19:
				stageButtons[i].frame = CGRectMake(221.0, 35.0, 30.0, 30.0);
				break;
			case 20:
				stageButtons[i].frame = CGRectMake(259.0, 75.0, 30.0, 30.0);
				break;
			default:
				break;
		}
		
		// Link the button to the IBAction method.
		[stageButtons[i] addTarget:self action:@selector(switchViewToGame:) forControlEvents:UIControlEventTouchUpInside];
		
		// Add to the view.
		[self.view addSubview:stageButtons[i]];
	}
}

- (AVPlaybackSoundController *)theBGMObject
{
	id theDelegate = [UIApplication sharedApplication].delegate;
	AVPlaybackSoundController *theBGMController;
	theBGMController = ((Elemental_SymphonyAppDelegate *)theDelegate).avPlaybackSoundController;
	return theBGMController;
}

- (void)viewWillAppear:(BOOL)animated
{
	[self initializeMapStageButtons];
	
	// If the BGM is not playing, then player just quitted from a game, restart the music.
	AVPlaybackSoundController *BGMController = [self theBGMObject];
	[BGMController startPlayer];
	
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	for (int i = 0; i < 21; ++i)
	{
		// Remove the button from the super view.
		if (stageButtons[i].superview != nil)
		{
			[stageButtons[i] removeFromSuperview];
		}
		
		[stageButtons[i] release];
	}
	
	[super viewWillDisappear:animated];
}

// Switch view to see game options.
- (IBAction)switchViewToOption:(id)sender
{
	if(optionViewController == nil)
	{
		Elemental_SymphonyOptionViewController *optionController = [[Elemental_SymphonyOptionViewController alloc] initWithNibName:@"Elemental_SymphonyOptionViewController" bundle:nil];
		self.optionViewController = optionController;
		[optionController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];

	[self presentModalViewController:optionViewController animated:YES];
}

// Switch view to confirm before actually play the game.
- (IBAction)switchViewToGame:(id)sender
{
	// Set the game stage number.
	for (int i = 0; i < 21; ++i) 
	{
		if(sender == stageButtons[i])
		{
			[GameUtils setCurrentGameStage:i];
			break;
		}
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	// Create a new view for this every game.
	Elemental_SymphonyBeforeGameViewController *beforeGameController = [[Elemental_SymphonyBeforeGameViewController alloc] initWithNibName:@"Elemental_SymphonyBeforeGameViewController" bundle:nil];
	self.beforeGameViewController = beforeGameController;
	[beforeGameController release];
	
	// Present without animation.
	[self presentModalViewController:beforeGameViewController animated:NO];
}

// Switch view to see player's status.
- (IBAction)switchViewToSeeStatus:(id)sender
{
	if(statusViewController == nil)
	{
		Elemental_SymphonyStatusViewController *statusController = [[Elemental_SymphonyStatusViewController alloc] initWithNibName:@"Elemental_SymphonyStatusViewController" bundle:nil];
		self.statusViewController = statusController;
		[statusController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];

	[self presentModalViewController:statusViewController animated:YES];
}

// Switch view to the info view.
- (IBAction)switchViewToInfo:(id)sender
{
	if(infoViewController == nil)
	{
		Elemental_SymphonyInfoViewController *infoController = [[Elemental_SymphonyInfoViewController alloc] initWithNibName:@"Elemental_SymphonyInfoViewController" bundle:nil];
		self.infoViewController = infoController;
		[infoController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:infoViewController animated:YES];
}

// Switch view to upgrade units.
- (IBAction)switchViewToUnit:(id)sender
{
	if(unitUpgradeViewController == nil)
	{
		UnitUpgradeViewController *unitController = [[UnitUpgradeViewController alloc] initWithNibName:@"UnitUpgradeViewController" bundle:nil];
		self.unitUpgradeViewController = unitController;
		[unitController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:unitUpgradeViewController animated:YES];
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
	
	self.statusButton = nil;
	self.unitsButton = nil;
	self.infosButton = nil;
	self.optionsButton = nil;
	
	self.statusViewController = nil;
	self.optionViewController = nil;
	self.unitUpgradeViewController = nil;
	self.beforeGameViewController = nil;
	self.infoViewController = nil;
}

- (void)dealloc
{
	[statusButton release];
	[unitsButton release];
	[infosButton release];
	[optionsButton release];
	[statusViewController release];
	[optionViewController release];
	[unitUpgradeViewController release];
	[beforeGameViewController release];
	[infoViewController release];
	
    [super dealloc];
}

@end
