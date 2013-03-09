//
//  Elemental_SymphonyPrizeViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/23/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyPrizeViewController.h"
#import "UserInformation.h"

@implementation Elemental_SymphonyPrizeViewController

@synthesize continueButton;
@synthesize selectedImageView;
@synthesize firstPrizeView;
@synthesize secondPrizeView;

// For player interaction.
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint touchPoint = [touch locationInView:touch.view];
	
	if (selectedImageView == nil)
	{
		UIImage *selectionImage = [UIImage imageNamed:@"ES_StageCleared_Selected.png"];
		selectedImageView = [[UIImageView alloc] initWithImage:selectionImage];
	}
	
	// Put the "selected" image on the view.
	if ([GameUtils CGPointInsideCGRect:touchPoint :firstPrizeView.frame])
	{
		CGRect rect = selectedImageView.frame;
		rect.origin.x = 58;
		rect.origin.y = 85;
		
		selectedImageView.frame = rect;
		
		selection = 1;
		
		[self.view addSubview:selectedImageView];
	}
	else if ([GameUtils CGPointInsideCGRect:touchPoint :secondPrizeView.frame])
	{
		CGRect rect = selectedImageView.frame;
		rect.origin.x = 58;
		rect.origin.y = 230;
		
		selectedImageView.frame = rect;
		
		selection = 2;
		
		[self.view addSubview:selectedImageView];
	}
	// Otherwise just ignore.
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Set the button images.
	UIImage *continueNormal = [UIImage imageNamed:@"ES_Button_ClearedContinue.png"];
	[continueButton setBackgroundImage:continueNormal forState:UIControlStateNormal];
	
	UIImage *continuePressed = [UIImage imageNamed:@"ES_Button_ClearedContinue_Press.png"];
	[continueButton setBackgroundImage:continuePressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	selection = 0;		// Set it to not selected.
	
	int gameStage = [GameUtils getCurrentGameStage];	// This number is ranged from 0 to 20, 
														// 20 being the arena.
	
	switch (gameStage)
	{
		case 0:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Fence.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx1.png"];
			break;
		case 1:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_VolvanicEruption.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx2.png"];
			break;
		case 2:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Sorceress.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx2.png"];
			break;
		case 3:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_GoldenTouch.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx5.png"];
			break;
		case 4:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_50MP.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx2.png"];
			break;
		case 5:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_IncendiaryUnit.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx2.png"];
			break;
		case 6:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_GuardianAngel.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx4.png"];
			break;
		case 7:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_BiochemicalEngineer.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx3.png"];
			break;
		case 8:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_UVFlowerPowder.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx4.png"];
			break;
		case 9:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_100MP.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx3.png"];
			break;
		case 10:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Iceman.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx4.png"];
			break;
		case 11:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_TargetLock.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx3.png"];
			break;
		case 12:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Gladiator.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx4.png"];
			break;
		case 13:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_HolyLight.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx5.png"];
			break;
		case 14:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_150MP.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx4.png"];
			break;
		case 15:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Archer.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx4.png"];
			break;
		case 16:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_SnowLotus.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx5.png"];
			break;
		case 17:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_MoonSoldier.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx5.png"];
			break;
		case 18:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Health.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx5.png"];
			break;
		case 19:
			firstPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_200MP.png"];
			secondPrizeView.image = [UIImage imageNamed:@"ES_StageCleared_Rockx5.png"];
			break;
		default:
			break;
	}
	
	[super viewWillAppear:animated];
}

// This method is called when the continue button is clicked.
- (IBAction)continueButtonClicked:(id)sender
{
	// Check selection.
	if (selection == 0)
	{
		// pop up a warning
		UIAlertView *prizeAlert = [[UIAlertView alloc] initWithTitle:@"ERROR" 
															message:@"PLEASE CHOOSE A PRIZE BEFORE CONTINUE." 
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		
		[prizeAlert show];
		[prizeAlert release];
		
		return;
	}
	
	// Apply the prize.
	[self applyChosenPrize];
	
	// Save the game.
	[GameUtils saveTheGame];
	
	// pop up a message
	UIAlertView *saveMessage = [[UIAlertView alloc] initWithTitle:@"DATA SAVED" 
														 message:@"YOUR GAME HAS BEEN SAVED." 
														delegate:nil
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil];
	[saveMessage show];
	[saveMessage release];
	
	// Go to the map view.
	// Current parent view is the game view, game view's parent view is the confirm view,
	// confirm view's parent view is the map view.
	[self.parentViewController.parentViewController.parentViewController dismissModalViewControllerAnimated:YES];
}

// Call this method after user click the continue button to apply the chosen prize.
- (void)applyChosenPrize
{
	UserInformation *UInfo = [UserInformation sharedManager];
		
	int gameStage = [GameUtils getCurrentGameStage];	// This number is ranged from 0 to 20, 
	
	if (gameStage != 20)	// Can never pass arena stage.
	{
		[UInfo setPassedStages:gameStage withBoolean:YES];
	}
	
	switch (gameStage)
	{
		case 0:
			if (selection == 1)
			{
				// Fense.
				[UInfo setSkills:15 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone ++;
			}
			break;
		case 1:
			if (selection == 1)
			{
				// Volvanic Eruption.
				[UInfo setSkills:7 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 2;
			}
			break;
		case 2:
			if (selection == 1)
			{
				// Sorceress.
				[UInfo setSkills:16 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 2;
			}
			break;
		case 3:
			if (selection == 1)
			{
				// Golden Touch.
				[UInfo setSkills:6 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 5;
			}
			break;
		case 4:
			if (selection == 1)
			{
				// 50 MP.
				UInfo.maxMagic += 50;
			}
			else
			{
				UInfo.numLevelUpStone += 2;
			}
			break;
		case 5:
			if (selection == 1)
			{
				// Incendiary Unit.
				[UInfo setSkills:3 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 2;
			}
			break;
		case 6:
			if (selection == 1)
			{
				// Guardian Angel.
				[UInfo setSkills:13 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 4;
			}
			break;
		case 7:
			if (selection == 1)
			{
				// Biochemical Engineer.
				[UInfo setSkills:9 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 3;
			}
			break;
		case 8:
			if (selection == 1)
			{
				// UV FLower Powder.
				[UInfo setSkills:1 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 4;
			}
			break;
		case 9:
			if (selection == 1)
			{
				// 100 MP.
				UInfo.maxMagic += 100;
			}
			else
			{
				UInfo.numLevelUpStone += 3;
			}
			break;
		case 10:
			if (selection == 1)
			{
				// Ice man.
				[UInfo setSkills:5 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 4;
			}
			break;
		case 11:
			if (selection == 1)
			{
				// Target Lock.
				[UInfo setSkills:0 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 3;
			}
			break;
		case 12:
			if (selection == 1)
			{
				// Gladiator.
				[UInfo setSkills:2 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 4;
			}
			break;
		case 13:
			if (selection == 1)
			{
				// Holy Light.
				[UInfo setSkills:8 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 5;
			}
			break;
		case 14:
			if (selection == 1)
			{
				// 150 MP.
				UInfo.maxMagic += 150;
			}
			else
			{
				UInfo.numLevelUpStone += 4;
			}
			break;
		case 15:
			if (selection == 1)
			{
				// Archer.
				[UInfo setSkills:4 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 4;
			}
			break;
		case 16:
			if (selection == 1)
			{
				// Snow Lotus.
				[UInfo setSkills:12 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 5;
			}
			break;
		case 17:
			if (selection == 1)
			{
				// Moon Soldier.
				[UInfo setSkills:10 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 5;
			}
			break;
		case 18:
			if (selection == 1)
			{
				// Health.
				[UInfo setSkills:14 withNumber:1];
			}
			else
			{
				UInfo.numLevelUpStone += 5;
			}
			break;
		case 19:
			if (selection == 1)
			{
				// 200 MP.
				UInfo.maxMagic += 200;
			}
			else
			{
				UInfo.numLevelUpStone += 5;
			}
			break;
		default:
			break;
	}
}

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.continueButton = nil;
	self.selectedImageView = nil;
	self.firstPrizeView = nil;
	self.secondPrizeView = nil;
}

- (void)dealloc 
{
	[continueButton release];
	[selectedImageView release];
	[firstPrizeView release];
	[secondPrizeView release];
	
    [super dealloc];
}

@end
