//
//  UnitUpgradeViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/17/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "UnitUpgradeViewController.h"
#import "UserInformation.h"
#import "UnitCellInUpgrade.h"
#import "GameUtils.h"
#import "Skill.h"
#import "MagicEruption.h"
#import "MagicGold.h"
#import "MagicTreatment.h"
#import "MagicVirus.h"
#import "MagicTarget.h"
#import "MagicSnowLotus.h"
#import "MagicThorn.h"
#import "MagicHolyLight.h"

@implementation UnitUpgradeViewController

@synthesize samariumRockLabel;
@synthesize previousPageButton;
@synthesize nextPageButton;
@synthesize firstSkillView;
@synthesize secondSkillView;
@synthesize thirdSkillView;
@synthesize firstButton;
@synthesize secondButton;
@synthesize thirdButton;
@synthesize first0Label, first1Label, first2Label, first3Label, first4Label, first5Label;
@synthesize second0Label, second1Label, second2Label, second3Label, second4Label, second5Label;
@synthesize third0Label, third1Label, third2Label, third3Label, third4Label, third5Label;
@synthesize skillImageView1, skillImageView2, skillImageView3, skillImageView4, skillImageView5, skillImageView6;
@synthesize pageLabel;
@synthesize goBackButton;

// For player interaction.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint touchPoint = [touch locationInView:touch.view];
	
	// Check to see if player touched one of the three skill cells.
	
	int skillIndex = 0;
	if ([GameUtils CGPointInsideCGRect:touchPoint :firstSkillView.frame])
	{		
		skillIndex = currentPage * 3;
	}
	else if ([GameUtils CGPointInsideCGRect:touchPoint :secondSkillView.frame])
	{
		skillIndex = currentPage * 3 + 1;
	}
	else if ([GameUtils CGPointInsideCGRect:touchPoint :thirdSkillView.frame])
	{
		skillIndex = currentPage * 3 + 2;
	}
	else
	{
		return;
	}
		
	UnitCellInUpgrade *unit = [availableSkills objectAtIndex:skillIndex];
	
	currentlySelectedSkill = unit.skillNumber;
	
	draggingImageView = [[UIImageView alloc] initWithImage:unit.iconImage];
	CGRect frame = draggingImageView.frame;
	frame.origin.x = touchPoint.x - 24;
	frame.origin.y = touchPoint.y - 50;
	draggingImageView.frame = frame;
	
	[self.view addSubview:draggingImageView];	
}

// For player interaction.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(draggingImageView != nil)
	{
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint touchLocation = [touch locationInView:touch.view];
		
		// Move the draggingImage.
		CGRect newFrame = draggingImageView.frame;
		newFrame.origin = CGPointMake(touchLocation.x - 24, touchLocation.y - 50);
		draggingImageView.frame = newFrame;
	}
}

// Check if the point is in any of the using skill grid, and return the view.
// If not, then return nil.
- (UIImageView *)pointInsideSkillGrids:(CGPoint)point
{
	if ([GameUtils CGPointInsideCGRect:point :skillImageView1.frame])
	{
		return skillImageView1;
	}
	else if ([GameUtils CGPointInsideCGRect:point :skillImageView2.frame])
	{
		return skillImageView2;
	}
	else if ([GameUtils CGPointInsideCGRect:point :skillImageView3.frame])
	{
		return skillImageView3;
	}
	else if ([GameUtils CGPointInsideCGRect:point :skillImageView4.frame])
	{
		return skillImageView4;
	}
	else if ([GameUtils CGPointInsideCGRect:point :skillImageView5.frame])
	{
		return skillImageView5;
	}
	else if ([GameUtils CGPointInsideCGRect:point :skillImageView6.frame])
	{
		return skillImageView6;
	}
	else 
	{
		return nil;
	}
}

// For player interaction.
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (draggingImageView == nil)
	{
		return;
	}
		
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint touchLocation = [touch locationInView:touch.view];
	
	// Get the skill view.
	UIImageView *currentSkillView = [self pointInsideSkillGrids:touchLocation];
	
	if (currentSkillView == nil)
	{
		// Re-set the dragging image.
		[draggingImageView removeFromSuperview];
		draggingImageView = nil;
		
		return;
	}
	
	currentSkillView.image = draggingImageView.image;
	
	int index = -1;
	if (currentSkillView == skillImageView1)
		index = 0;
	else if (currentSkillView == skillImageView2)
		index = 1;
	else if (currentSkillView == skillImageView3)
		index = 2;
	else if (currentSkillView == skillImageView4)
		index = 3;
	else if (currentSkillView == skillImageView5)
		index = 4;
	else 
		index = 5;
	
	// Save the result to user data.
	UserInformation *UInfo = [UserInformation sharedManager];
	[UInfo setUsingSkills:index withSkill:currentlySelectedSkill + 1];
	
	// Make sure no repetition.
	for (int i = 0; i < 6; i++)
	{
		if (i == index)
		{
			continue;
		}
		
		if ([UInfo usingSkills:i] == [UInfo usingSkills:index])
		{
			// Found a repetition, take it off.
			switch (i)
			{
				case 0:
					skillImageView1.image = nil;
					break;
				case 1:
					skillImageView2.image = nil;
					break;
				case 2:
					skillImageView3.image = nil;
					break;
				case 3:
					skillImageView4.image = nil;
					break;
				case 4:
					skillImageView5.image = nil;
					break;
				case 5:
					skillImageView6.image = nil;
					break;
				default:
					break;
			}
			
			[UInfo setUsingSkills:i withSkill:0];
		}
	}
	
	modified = YES;
	
	// Re-set the dragging image.
	[draggingImageView removeFromSuperview];
	draggingImageView = nil;
}

// Initialize the grids for the 6 skills.
- (void)initializeGrids
{
#define SKILL_GRID_WIDTH 49
#define SKILL_GRID_HEIGHT 49
	
	// Set the grids coordinates.
	skillsGrids[0][0].origin.x = 31;
	skillsGrids[0][0].origin.y = 360;
	skillsGrids[0][0].size.width = SKILL_GRID_WIDTH;
	skillsGrids[0][0].size.height = SKILL_GRID_HEIGHT;

	skillsGrids[0][1].origin.x = 90;
	skillsGrids[0][1].origin.y = 360;
	skillsGrids[0][1].size.width = SKILL_GRID_WIDTH;
	skillsGrids[0][1].size.height = SKILL_GRID_HEIGHT;
	
	skillsGrids[0][2].origin.x = 149;
	skillsGrids[0][2].origin.y = 360;
	skillsGrids[0][2].size.width = SKILL_GRID_WIDTH;
	skillsGrids[0][2].size.height = SKILL_GRID_HEIGHT;
	
	skillsGrids[1][0].origin.x = 31;
	skillsGrids[1][0].origin.y = 419;
	skillsGrids[1][0].size.width = SKILL_GRID_WIDTH;
	skillsGrids[1][0].size.height = SKILL_GRID_HEIGHT;
	
	skillsGrids[1][1].origin.x = 90;
	skillsGrids[1][1].origin.y = 419;
	skillsGrids[1][1].size.width = SKILL_GRID_WIDTH;
	skillsGrids[1][1].size.height = SKILL_GRID_HEIGHT;
	
	skillsGrids[1][2].origin.x = 149;
	skillsGrids[1][2].origin.y = 419;
	skillsGrids[1][2].size.width = SKILL_GRID_WIDTH;
	skillsGrids[1][2].size.height = SKILL_GRID_HEIGHT;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Initialization.
	currentPage = 0;
	
	draggingImageView = nil;
	
	[self initializeGrids];
	
	// Set up the GUI components.
	
	UIImage *previousPageButtonNormal = [UIImage imageNamed:@"ES_Button_PreviousPage.png"];
	[previousPageButton setBackgroundImage:previousPageButtonNormal forState:UIControlStateNormal];
	
	UIImage *previousPageButtonPressed = [UIImage imageNamed:@"ES_Button_PreviousPage_Press.png"];
	[previousPageButton setBackgroundImage:previousPageButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *nextPageButtonNormal = [UIImage imageNamed:@"ES_Button_NextPage.png"];
	[nextPageButton setBackgroundImage:nextPageButtonNormal forState:UIControlStateNormal];
	
	UIImage *nextPageButtonPressed = [UIImage imageNamed:@"ES_Button_NextPage_Press.png"];
	[nextPageButton setBackgroundImage:nextPageButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *goBackButtonNormal = [UIImage imageNamed:@"ES_Button_Back.png"];
	[goBackButton setBackgroundImage:goBackButtonNormal forState:UIControlStateNormal];
	
	UIImage *goBackButtonPressed = [UIImage imageNamed:@"ES_Button_Back_Press.png"];
	[goBackButton setBackgroundImage:goBackButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *levelUpButtonNormal = [UIImage imageNamed:@"ES_Button_Lvup.png"];
	[firstButton setBackgroundImage:levelUpButtonNormal forState:UIControlStateNormal];
	[secondButton setBackgroundImage:levelUpButtonNormal forState:UIControlStateNormal];
	[thirdButton setBackgroundImage:levelUpButtonNormal forState:UIControlStateNormal];
	
	UIImage *levelUpButtonPressed = [UIImage imageNamed:@"ES_Button_Lvup_Press.png"];
	[firstButton setBackgroundImage:levelUpButtonPressed forState:UIControlStateHighlighted];
	[secondButton setBackgroundImage:levelUpButtonPressed forState:UIControlStateHighlighted];
	[thirdButton setBackgroundImage:levelUpButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *levelUpButtonDisabled = [UIImage imageNamed:@"ES_Button_Lvup_Max.png"];
	[firstButton setBackgroundImage:levelUpButtonDisabled forState:UIControlStateDisabled];
	[secondButton setBackgroundImage:levelUpButtonDisabled forState:UIControlStateDisabled];
	[thirdButton setBackgroundImage:levelUpButtonDisabled forState:UIControlStateDisabled];
	
    [super viewDidLoad];
}

// Hide the second cell of skill.
- (void)hideSecondCell
{
	[secondButton removeFromSuperview];
	[secondSkillView removeFromSuperview];
	
	[second0Label removeFromSuperview];
	[second1Label removeFromSuperview];
	[second2Label removeFromSuperview];
	[second3Label removeFromSuperview];
	[second4Label removeFromSuperview];
	[second5Label removeFromSuperview];
}

// Show the second cell of skill, ignored if it's already shown.
- (void)showSecondCell
{
	if ([secondButton superview] == nil)
	{
		[self.view addSubview:secondSkillView];
		
		[self.view addSubview:second0Label];
		[self.view addSubview:second1Label];
		[self.view addSubview:second2Label];
		[self.view addSubview:second3Label];
		[self.view addSubview:second4Label];
		[self.view addSubview:second5Label];
		
		[self.view addSubview:secondButton];
	}
}

// Hide the third cell of skill.
- (void)hideThirdCell
{
	[thirdButton removeFromSuperview];
	[thirdSkillView removeFromSuperview];
	
	[third0Label removeFromSuperview];
	[third1Label removeFromSuperview];
	[third2Label removeFromSuperview];
	[third3Label removeFromSuperview];
	[third4Label removeFromSuperview];
	[third5Label removeFromSuperview];
}

// Show the third cell of skill, ignored if it's already shown.
- (void)showThirdCell
{
	if ([thirdButton superview] == nil)
	{
		[self.view addSubview:thirdSkillView];
		
		[self.view addSubview:third0Label];
		[self.view addSubview:third1Label];
		[self.view addSubview:third2Label];
		[self.view addSubview:third3Label];
		[self.view addSubview:third4Label];
		[self.view addSubview:third5Label];
		
		[self.view addSubview:thirdButton];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	UserInformation *UInfo = [UserInformation sharedManager];
	
	modified = NO;
	
	// Get all available skills.
	availableSkills = [[NSMutableArray alloc] init];
	
	for (int index = 0; index < TOTAL_NUMBER_SKILLS; index ++)
	{
		int indicator = [UInfo skills:index];
		
		if (indicator != 0)
		{
			UnitCellInUpgrade *unit = [[UnitCellInUpgrade alloc] initWithSkillNum:index];
			
			[availableSkills addObject:unit];
			
			[unit release];
		}
	}
	
	// Set the number of Samarium stones.
	int numStones = UInfo.numLevelUpStone;
	NSString *samariumLabelString = [NSString stringWithFormat:@"Samarium Rock x %i", numStones];
	samariumRockLabel.text = samariumLabelString;
	
	// Set the 3 cells.
	int numAvailableSkills = [self setThreeCellsAccordingToCurrentPage];
	
	// Set the page number label.
	totalPageNumber = (numAvailableSkills + 2) / 3;
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/%i", currentPage + 1, totalPageNumber];
	pageLabel.text = pageLabelString;
	
	// Set the 6 currently using skills.
	[self setSixUsingSkills];
	
	// Set the buttons to initial state.
	if (currentPage == 0)
		previousPageButton.enabled = NO;
	else 
		previousPageButton.enabled = YES;

	if (currentPage + 1 == totalPageNumber)
		nextPageButton.enabled = NO;
	else
		nextPageButton.enabled = YES;
	
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	// Save the game.
	if (modified)
	{
		[GameUtils saveTheGame];
	}
	
	// Release the available skills.
	[availableSkills release];
	
	[super viewWillDisappear:animated];
}

// Go back to the map view.
- (IBAction)switchViewToGoback:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

// Player clicked upgrade button.
- (IBAction)upgradeSkill:(id)sender
{
	// Find out which button was clicked.
	int i;
	UILabel *levelLabel;
	if (sender == firstButton)
	{
		i = 0;
		levelLabel = first0Label;
	}
	else if (sender == secondButton)
	{
		i = 1;
		levelLabel = second0Label;
	}
	else
	{
		i = 2;
		levelLabel = third0Label;
	}
	
	// Check if player has enough rocks.
	UnitCellInUpgrade *unitCell = [availableSkills objectAtIndex:3 *currentPage + i];
	int skillNumber = unitCell.skillNumber;
	UserInformation *UInfo = [UserInformation sharedManager];
	int numRocksRequired = [UInfo skills:skillNumber];
	if (numRocksRequired > UInfo.numLevelUpStone)
	{
		// pop up a warning
		UIAlertView *rockAlert = [[UIAlertView alloc] initWithTitle:@"ERROR" 
															 message:@"YOU DO NOT HAVE ENOUGH SAMARIUM ROCKS FOR THIS UPGRADE." 
															delegate:nil
												   cancelButtonTitle:@"OK"
												   otherButtonTitles:nil];
		
		[rockAlert show];
		[rockAlert release];
		
		return;
	}
	
	// Set this boolean value for saving data.
	modified = YES;
	
	// Upgrade it.
	int newLevel = numRocksRequired + 1;
	if (newLevel == 4)
	{
		((UIButton *)sender).enabled = NO;
	}
	[UInfo setSkills:skillNumber withNumber:newLevel];
	levelLabel.text = [NSString stringWithFormat:@"%i", numRocksRequired];
	
	// Change other labels with green text.
	[self changeLabelsAfterUpgrade:i :skillNumber :numRocksRequired];
	
	// Take away the rocks.
	UInfo.numLevelUpStone -= numRocksRequired;
	NSString *samariumLabelString = [NSString stringWithFormat:@"Samarium Rock x %i", UInfo.numLevelUpStone];
	samariumRockLabel.text = samariumLabelString;
}

// cell: 0~2, skillNumber: 0~16, level: 1~3
- (void)changeLabelsAfterUpgrade:(int)cell :(int)skillNumber :(int)level
{
	UILabel *label2;
	UILabel *label3;
	UILabel *label4;
	UILabel *label5;
	UILabel *label6;
	
	if (cell == 0)
	{
		label2 = first1Label;
		label3 = first2Label;
		label4 = first3Label;
		label5 = first4Label;
		label6 = first5Label;
	}
	else if (cell == 1)
	{
		label2 = second1Label;
		label3 = second2Label;
		label4 = second3Label;
		label5 = second4Label;
		label6 = second5Label;
	}
	else
	{
		label2 = third1Label;
		label3 = third2Label;
		label4 = third3Label;
		label5 = third4Label;
		label6 = third5Label;
	}
	
	// Change the labels.
	if ([GameUtils isMagicalSkill:skillNumber + 1])
	{
		switch (skillNumber)
		{
			case 0:		// Target Lock.
			{
				label4.textColor = [UIColor blueColor];
				
				if (level == 1)
					label4.text = [NSString stringWithString:@"+4sec"];
				else if (level == 2)
					label4.text = [NSString stringWithString:@"+6sec"];
				else
					label4.text = [NSString stringWithString:@"+8sec"];
				break;
			}
			case 1:		// UV Flower Powder.
			{
				label2.textColor = [UIColor blueColor];
				
				if (level == 1)
					label2.text = [NSString stringWithString:@"+3"];
				else if (level == 2)
					label2.text = [NSString stringWithString:@"+3"];
				else
					label2.text = [NSString stringWithString:@"+3"];
				break;
			}
			case 6:		// Golden Touch.
			{
				label3.textColor = [UIColor blueColor];
				
				if (level == 1)
					label3.text = [NSString stringWithString:@"+100"];
				else if (level == 2)
					label3.text = [NSString stringWithString:@"+150"];
				else
					label3.text = [NSString stringWithString:@"+200"];
				break;
			}
			case 7:		// Volcanic Eruption.
			{
				label2.textColor = [UIColor blueColor];
				
				if (level == 1)
					label2.text = [NSString stringWithString:@"+3"];
				else if (level == 2)
					label2.text = [NSString stringWithString:@"+3"];
				else
					label2.text = [NSString stringWithString:@"+3"];
				break;
			}
			case 8:		// Holy Light.
			{
				label4.textColor = [UIColor blueColor];
				
				if (level == 1)
					label4.text = [NSString stringWithString:@"+4sec"];
				else if (level == 2)
					label4.text = [NSString stringWithString:@"+6sec"];
				else
					label4.text = [NSString stringWithString:@"+8sec"];
				break;
			}
			case 12:	// Snow Lotus.
			{
				label4.textColor = [UIColor blueColor];
				
				if (level == 1)
					label4.text = [NSString stringWithString:@"+3sec"];
				else if (level == 2)
					label4.text = [NSString stringWithString:@"+5sec"];
				else
					label4.text = [NSString stringWithString:@"+7sec"];
				break;
			}
			case 13:	// Guardian Angel.
			{
				label4.textColor = [UIColor blueColor];
				
				if (level == 1)
					label4.text = [NSString stringWithString:@"+4sec"];
				else if (level == 2)
					label4.text = [NSString stringWithString:@"+6sec"];
				else
					label4.text = [NSString stringWithString:@"+8sec"];
				break;
			}
			case 14:	// Health.
			{
				label6.textColor = [UIColor redColor];
				
				if (level == 1)
					label6.text = [NSString stringWithString:@"-20"];
				else if (level == 2)
					label6.text = [NSString stringWithString:@"-30"];
				else
					label6.text = [NSString stringWithString:@"-40"];
				break;
			}
			default:
				break;
		}
	}
	else
	{
		// Unit.
		if (skillNumber != 10 && skillNumber != 11 && skillNumber != 15)	// Not Fence, Foot Soldier, or Moon Soldier.
		{
			if (level == 1)
			{
				label2.textColor = [UIColor blueColor];
				
				label2.text = [NSString stringWithString:@"+20"];
			}
			else if (level == 2)
			{
				label3.textColor = [UIColor blueColor];
				
				label3.text = [NSString stringWithString:@"+10"];
			}
			else
			{
				label5.textColor = [UIColor blueColor];

				label5.text = [NSString stringWithString:@"+20%"];
			}
		}
		else if (skillNumber == 10 || skillNumber == 11)		// Foot Soldier or Moon Soldier.
		{
			if (level == 1)
			{
				label2.textColor = [UIColor blueColor];
				
				label2.text = [NSString stringWithString:@"+20"];
			}
			else if (level == 2)
			{
				label3.textColor = [UIColor blueColor];
				
				label3.text = [NSString stringWithString:@"+10"];
			}
			else
			{
				label4.textColor = [UIColor blueColor];
				
				label4.text = [NSString stringWithString:@"+20%"];
			}
		}
		else						// Fence.
		{
			label2.textColor = [UIColor blueColor];

			if (level == 1)
			{
				label2.text = [NSString stringWithString:@"+100"];
			}
			else if (level == 2)
			{
				label2.text = [NSString stringWithString:@"+100"];
			}
			else
			{				
				label2.text = [NSString stringWithString:@"+100"];
			}
		}
	}
}

// Set the images of 6 currently using skills.
- (void)setSixUsingSkills
{
	UserInformation *UInfo = [UserInformation sharedManager];
	
	for (int index = 0; index < 6; index ++)
	{
		int skillNumber = [UInfo usingSkills:index];
		
		if (skillNumber != 0)
		{
			skillNumber --;
			UnitCellInUpgrade *unit = [[UnitCellInUpgrade alloc] initWithSkillNum:skillNumber];
			
			switch (index)
			{
				case 0:
					skillImageView1.image = unit.iconImage;
					break;
				case 1:
					skillImageView2.image = unit.iconImage;
					break;
				case 2:
					skillImageView3.image = unit.iconImage;
					break;
				case 3:
					skillImageView4.image = unit.iconImage;
					break;
				case 4:
					skillImageView5.image = unit.iconImage;
					break;
				case 5:
					skillImageView6.image = unit.iconImage;
					break;
				default:
					break;
			}
			
			[unit release];
		}
	}
}

// Set the text on the skill labels. This is set for each cell when view appears.
- (void)displayAttributes:(int)cellNumber :(int)skillNumber
{
	UserInformation *UInfo = [UserInformation sharedManager];
	NSString *string1 = [NSString stringWithFormat:@"%i", [UInfo skills:skillNumber - 1] - 1];
	NSString *string2;
	NSString *string3;
	NSString *string4;
	NSString *string5;
	NSString *string6;
	
	if ([GameUtils isMagicalSkill:skillNumber])
	{
		switch (skillNumber)
		{
			case 1:
			{
				MagicTarget *magicTarget = [[MagicTarget alloc] initWithEnemy:nil];
				
				string2 = [NSString stringWithString:@"-"];
				string3 = [NSString stringWithString:@"-"];
				string4 = [NSString stringWithFormat:@"%isec", magicTarget.durationInSeconds];
				string5 = [NSString stringWithString:@"All"];
				string6 = [NSString stringWithFormat:@"%iM", magicTarget.magicCost];
				
				[magicTarget release];
				
				break;
			}
			case 2:
			{
				MagicVirus *magicVirus = [[MagicVirus alloc] init];
				
				string2 = [NSString stringWithFormat:@"%i", (int)(magicVirus.attack * 30)];
				string3 = [NSString stringWithString:@"-"];
				string4 = [NSString stringWithString:@"30sec"];
				string5 = [NSString stringWithString:@"8x2"];
				string6 = [NSString stringWithFormat:@"%iM", magicVirus.magicCost];
				
				[magicVirus release];
				
				break;
			}
			case 7:
			{
				MagicGold *magicGold = [[MagicGold alloc] init];
				
				string2 = [NSString stringWithFormat:@"-%iHP", magicGold.hpReduced];
				string3 = [NSString stringWithFormat:@"+%iG", magicGold.goldAdded];
				string4 = [NSString stringWithString:@"-"];
				string5 = [NSString stringWithString:@"-"];
				string6 = [NSString stringWithFormat:@"%iM", magicGold.magicCost];
				
				[magicGold release];
				
				break;
			}
			case 8:
			{
				MagicEruption *magicEruption = [[MagicEruption alloc] init];
				
				string2 = [NSString stringWithFormat:@"%i", (int)(magicEruption.attack * 30)];
				string3 = [NSString stringWithString:@"-"];
				string4 = [NSString stringWithString:@"-"];
				string5 = [NSString stringWithString:@"3x3"];
				string6 = [NSString stringWithFormat:@"%iM", magicEruption.magicCost];
				
				[magicEruption release];
				
				break;
			}
			case 9:
			{
				MagicHolyLight *magicHolyLight = [[MagicHolyLight alloc] initWithAffectingUnit:nil];
				
				string2 = [NSString stringWithString:@"-"];
				string3 = [NSString stringWithString:@"ATKx2"];
				string4 = [NSString stringWithFormat:@"%isec", magicHolyLight.durationInSeconds];
				string5 = [NSString stringWithString:@"All"];
				string6 = [NSString stringWithFormat:@"%iM", magicHolyLight.magicCost];
				
				[magicHolyLight release];
				
				break;
			}
			case 13:
			{
				MagicSnowLotus *magicSnowLotus = [[MagicSnowLotus alloc] initWithAffectingEnemy:nil];
				
				string2 = [NSString stringWithString:@"-"];
				string3 = [NSString stringWithString:@"-"];
				string4 = [NSString stringWithFormat:@"%isec", magicSnowLotus.durationInSeconds];
				string5 = [NSString stringWithString:@"All"];
				string6 = [NSString stringWithFormat:@"%iM", magicSnowLotus.magicCost];
				
				[magicSnowLotus release];
				
				break;
			}
			case 14:
			{
				MagicThorn *magicThorn = [[MagicThorn alloc] initWithUnit:nil];
				
				string2 = [NSString stringWithString:@"-"];
				string3 = [NSString stringWithString:@"DEF"];
				string4 = [NSString stringWithFormat:@"%isec", magicThorn.durationInSeconds];
				string5 = [NSString stringWithString:@"Single"];
				string6 = [NSString stringWithFormat:@"%iM", magicThorn.magicCost];
				
				[magicThorn release];
				
				break;
			}
			case 15:
			{
				MagicTreatment *magicTreatment = [[MagicTreatment alloc] init];
				
				string2 = [NSString stringWithString:@"-"];
				string3 = [NSString stringWithString:@"HLT"];
				string4 = [NSString stringWithString:@"-"];
				string5 = [NSString stringWithString:@"All"];
				string6 = [NSString stringWithFormat:@"%iM", magicTreatment.magicCost];
				
				[magicTreatment release];
				
				break;
			}
			default:
				break;
		}
	}
	else
	{
		Skill *skill = [[Skill alloc] initWithSkillNumber:skillNumber];
		
		if (skillNumber == 16)		// Fence.
		{
			string2 = [NSString stringWithFormat:@"%i", (int)(skill.totalHealth)];
			string3 = [NSString stringWithString:@"-"];
			string4 = [NSString stringWithString:@"-"];
			string5 = [NSString stringWithString:@"-"];
			string6 = [NSString stringWithFormat:@"%iG", skill.amount];
		}
		else
		{
			string2 = [NSString stringWithFormat:@"%i", (int)(skill.totalHealth)];
			string3 = [NSString stringWithFormat:@"%i", skill.attack];
			string4 = [NSString stringWithFormat:@"%i%%", (int)(skill.dodgeRate * 100)];
			string5 = [NSString stringWithFormat:@"%i%%", (int)(skill.criticalRate * 100)];
			string6 = [NSString stringWithFormat:@"%iG", skill.amount];
		}
		
		[skill release];
	}
	
	switch (cellNumber)
	{
		case 0:
			first0Label.text = string1;
			first1Label.text = string2;
			first2Label.text = string3;
			first3Label.text = string4;
			first4Label.text = string5;
			first5Label.text = string6;
			
			first0Label.textColor = [UIColor blackColor];
			first1Label.textColor = [UIColor blackColor];
			first2Label.textColor = [UIColor blackColor];
			first3Label.textColor = [UIColor blackColor];
			first4Label.textColor = [UIColor blackColor];
			first5Label.textColor = [UIColor blackColor];
			break;
		case 1:
			second0Label.text = string1;
			second1Label.text = string2;
			second2Label.text = string3;
			second3Label.text = string4;
			second4Label.text = string5;
			second5Label.text = string6;
			
			second0Label.textColor = [UIColor blackColor];
			second1Label.textColor = [UIColor blackColor];
			second2Label.textColor = [UIColor blackColor];
			second3Label.textColor = [UIColor blackColor];
			second4Label.textColor = [UIColor blackColor];
			second5Label.textColor = [UIColor blackColor];
			break;
		case 2:
			third0Label.text = string1;
			third1Label.text = string2;
			third2Label.text = string3;
			third3Label.text = string4;
			third4Label.text = string5;
			third5Label.text = string6;
			
			third0Label.textColor = [UIColor blackColor];
			third1Label.textColor = [UIColor blackColor];
			third2Label.textColor = [UIColor blackColor];
			third3Label.textColor = [UIColor blackColor];
			third4Label.textColor = [UIColor blackColor];
			third5Label.textColor = [UIColor blackColor];
			break;
		default:
			break;
	}
}

// Set the skills in the 3 cells according to the value of currentPage.
// Return the number of available skills totally.
// Assume the array available skills is populated.
- (int)setThreeCellsAccordingToCurrentPage
{
	UserInformation *UInfo = [UserInformation sharedManager];

	// First one:
	int index = currentPage * 3;
	
	if ([availableSkills count] > index)
	{
		UnitCellInUpgrade *unitCell = [availableSkills objectAtIndex:index];
		firstSkillView.image = unitCell.baseImage;
		
		// Set the level up button.
		if ([UInfo skills:unitCell.skillNumber] == 4)
		{
			firstButton.enabled = NO;
		}
		else
		{
			firstButton.enabled = YES;
		}
		
		// Set 6 attributes.
		[self displayAttributes:0 :unitCell.skillNumber + 1];
	}
	
	// Second one:
	index ++;
	
	if ([availableSkills count] > index)
	{
		UnitCellInUpgrade *unitCell = [availableSkills objectAtIndex:index];
		secondSkillView.image = unitCell.baseImage;
		
		[self showSecondCell];
		
		// Set the level up button.
		if ([UInfo skills:unitCell.skillNumber] == 4)
		{
			secondButton.enabled = NO;
		}
		else
		{
			secondButton.enabled = YES;
		}
		
		// Set 6 attributes.
		[self displayAttributes:1 :unitCell.skillNumber + 1];
	}
	else 
	{
		[self hideSecondCell];
	}
	
	
	// Third one:
	index ++;
	
	if ([availableSkills count] > index)
	{
		UnitCellInUpgrade *unitCell = [availableSkills objectAtIndex:index];
		thirdSkillView.image = unitCell.baseImage;
		
		[self showThirdCell];
		
		// Set the level up button.
		if ([UInfo skills:unitCell.skillNumber] == 4)
		{
			thirdButton.enabled = NO;
		}
		else
		{
			thirdButton.enabled = YES;
		}
		
		// Set 6 attributes.
		[self displayAttributes:2 :unitCell.skillNumber + 1];
	}
	else 
	{
		[self hideThirdCell];
	}
	
	int result = [availableSkills count];
		
	return result;
}

// Show the next three skills.
- (IBAction)goToNextPage:(id)sender
{
	currentPage ++;
	
	int realPageNumber = currentPage + 1;
	
	// Change page number.
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/%i", realPageNumber, totalPageNumber];
	pageLabel.text = pageLabelString;
	
	if (realPageNumber == totalPageNumber) 
	{
		nextPageButton.enabled = NO;
	}
	
	if (previousPageButton.enabled == NO)
	{
		previousPageButton.enabled = YES;
	}
	
	// Reset the 3 cells.
	[self setThreeCellsAccordingToCurrentPage];
}

// Show the previous three skills.
- (IBAction)gotoPrevPage:(id)sender
{
	currentPage --;
	
	int realPageNumber = currentPage + 1;
	
	// Change page number.
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/%i", realPageNumber, totalPageNumber];
	pageLabel.text = pageLabelString;
	
	if (realPageNumber == 1)
	{
		previousPageButton.enabled = NO;
	}
	
	if (nextPageButton.enabled == NO)
	{
		nextPageButton.enabled = YES;
	}
	
	// Reset the 3 cells.
	[self setThreeCellsAccordingToCurrentPage];
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
	
	self.samariumRockLabel = nil;
	self.previousPageButton = nil;
	self.nextPageButton = nil;
	self.firstSkillView = nil;
	self.secondSkillView = nil;
	self.thirdSkillView = nil;
	self.firstButton = nil;
	self.secondButton = nil;
	self.thirdButton = nil;
	self.first0Label = nil;
	self.first1Label = nil;
	self.first2Label = nil;
	self.first3Label = nil;
	self.first4Label = nil;
	self.first5Label = nil;
	self.second0Label = nil;
	self.second1Label = nil;
	self.second2Label = nil;
	self.second3Label = nil;
	self.second4Label = nil;
	self.second5Label = nil;
	self.third0Label = nil;
	self.third1Label = nil;
	self.third2Label = nil;
	self.third3Label = nil;
	self.third4Label = nil;
	self.third5Label = nil;
	self.skillImageView1 = nil;
	self.skillImageView2 = nil;
	self.skillImageView3 = nil;
	self.skillImageView4 = nil;
	self.skillImageView5 = nil;
	self.skillImageView6 = nil;
	self.pageLabel = nil;
	self.goBackButton = nil;
}

- (void)dealloc 
{
	[samariumRockLabel release];
	[previousPageButton release];
	[nextPageButton release];
	[firstSkillView release];
	[secondSkillView release];
	[thirdSkillView release];
	[firstButton release];
	[secondButton release];
	[thirdButton release];
	[first0Label release];
	[first1Label release];
	[first2Label release];
	[first3Label release];
	[first4Label release];
	[first5Label release];
	[second0Label release];
	[second1Label release];
	[second2Label release];
	[second3Label release];
	[second4Label release];
	[second5Label release];
	[third0Label release];
	[third1Label release];
	[third2Label release];
	[third3Label release];
	[third4Label release];
	[third5Label release];
	[skillImageView1 release];
	[skillImageView2 release];
	[skillImageView3 release];
	[skillImageView4 release];
	[skillImageView5 release];
	[skillImageView6 release];
	[pageLabel release];
	[goBackButton release];
	
    [super dealloc];
}

@end
