//
//  Elemental_symphonyEnvViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#include <unistd.h>
#import "Elemental_SymphonyGameViewController.h"
#import "Elemental_SymphonyGameMenuViewController.h"
#import "Elemental_SymphonyGameOverViewController.h"
#import "Elemental_SymphonyPrizeViewController.h"
#import "Elemental_SymphonyArenaScoreViewController.h"
#import "AVPlaybackSoundController.h"
#import "Elemental_SymphonyAppDelegate.h"
#import "UserInformation.h"
#import "GameUtils.h"
#import "Skill.h"
#import "Bullet.h"
#import "EnemyUnit.h"
#import "MagicEruption.h"
#import "MagicGold.h"
#import "MagicTreatment.h"
#import "MagicVirus.h"
#import "MagicTarget.h"
#import "MagicSnowLotus.h"
#import "MagicThorn.h"
#import "MagicHolyLight.h"
#import "AttackMissView.h"

@implementation Elemental_SymphonyGameViewController

@synthesize baseImage;
@synthesize gameMenuButton;
@synthesize gameMenuViewController;
@synthesize gameOverViewController;
@synthesize prizeViewController;
@synthesize arenaScoreViewController;
@synthesize healthImage;
@synthesize healthLabel;
@synthesize magicImage;
@synthesize magicLabel;
@synthesize moneyLabel;
@synthesize numberOfEnemiesLabel;
@synthesize draggingImage;
@synthesize firstAmount;
@synthesize secondAmount;
@synthesize thirdAmount;
@synthesize fourthAmount;
@synthesize fifthAmount;
@synthesize sixthAmount;
@synthesize specialFieldLabel;

// For player interaction.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(isPlaying)
	{
		UITouch *touch = [[event allTouches] anyObject];
		touchPoint = [touch locationInView:touch.view];
		
		// Check to see if player touched any of the skills.
		for (int i=0; i < 6; ++i)
		{
			if ([GameUtils CGPointInsideCGRect:touchPoint :skills[i].skillImage.frame])
			{
				if (skills[i].skillNumber == 0 || skills[i].isAvailable == NO)
				{
					return;
				}
				
				currentSkillNumber = i;
				
				// Get the global skill number.
				UserInformation *UInfo = [UserInformation sharedManager];
				selectedUsingSkill = [UInfo usingSkills:i];
				
				// Check if this is a magic skill.
				if ([GameUtils isMagicalSkill:selectedUsingSkill]) 
				{
					// This is a magic skill.
					switch (selectedUsingSkill)
					{						
						case 1:			// Accurate.
						{
							MagicTarget *magicTarget = [[MagicTarget alloc] initWithEnemy:nil];
							
							currentMagic = magicTarget;
							
							break;
						}
						case 2:			// Corrosion.
						{
							MagicVirus *magicVirus = [[MagicVirus alloc] init];
							
							draggingImage = [[UIImageView alloc] initWithImage:magicVirus.draggingImage];
							
							CGRect frame = draggingImage.frame;
							frame.origin.x = touchPoint.x - 51;
							frame.origin.y = touchPoint.y - 152;
							draggingImage.frame = frame;
							
							[self.view addSubview:draggingImage];
							
							currentMagic = magicVirus;
							
							break;
						}
						case 7:			// Gold.
						{
							MagicGold *magicGold = [[MagicGold alloc] init];
							
							currentMagic = magicGold;

							break;
						}
						case 8:			// Lava.
						{
							MagicEruption *magicEruption = [[MagicEruption alloc] init];
														
							draggingImage = [[UIImageView alloc] initWithImage:magicEruption.draggingImage];
							
							CGRect frame = draggingImage.frame;
							frame.origin.x = touchPoint.x - 76;
							frame.origin.y = touchPoint.y - 57;
							draggingImage.frame = frame;

							[self.view addSubview:draggingImage];
							
							currentMagic = magicEruption;

							break;
						}
						case 9:			// Lighting.
						{
							MagicHolyLight *magicHolyLight = [[MagicHolyLight alloc] initWithAffectingUnit:nil];
							
							currentMagic = magicHolyLight;
							
							break;
						}
						case 13:		// SnowLotus.
						{
							MagicSnowLotus *magicSnowLotus = [[MagicSnowLotus alloc] initWithAffectingEnemy:nil];
														
							currentMagic = magicSnowLotus;
							
							break;
						}
						case 14:		// Thorn.
						{
							MagicThorn *magicThorn = [[MagicThorn alloc] initWithUnit:nil];
							
							draggingImage = [[UIImageView alloc] initWithImage:magicThorn.draggingImage];
							
							CGRect frame = draggingImage.frame;
							frame.origin.x = touchPoint.x - 25;
							frame.origin.y = touchPoint.y - 55.0;
							draggingImage.frame = frame;
							
							[self.view addSubview:draggingImage];
							
							currentMagic = magicThorn;

							break;
						}
						case 15:		// Treatment.
						{
							MagicTreatment *magicTreatment = [[MagicTreatment alloc] init];
							
							currentMagic = magicTreatment;

							break;
						}
						default:
							break;
					}
				}
				else 
				{
					// This is a summon skill, initialize the dragging image.
					draggingImage = [[UIImageView alloc] initWithImage:skills[i].setImage];

					CGRect frame = draggingImage.frame;
					frame.origin = skills[i].skillImage.frame.origin;
					draggingImage.frame = frame;
					
					currentMagic = nil;
					
					[self.view addSubview:draggingImage];					
				}
				
				break;
			}
		}
	}
}

// For player interaction.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(isPlaying && (draggingImage != nil || currentMagic != nil))
	{
		UITouch *touch = [[event allTouches] anyObject];
		CGPoint touchLocation = [touch locationInView:touch.view];
		
		// The current row and column the finger is on.
		int row = (touchLocation.y - 40) / 38;
		int col = (touchLocation.x - 7) / 51;
		
		if (currentMagic == nil)
		{
			// Show which grid it is current on.
			if (touchLocation.x >=7 && touchLocation.x <= 313 && 
				touchLocation.y >= 40 && touchLocation.y <= 344) 
			{
				if (gridView != nil && ![GameUtils compareCGRect:grids[row][col] isSameAs:gridView.frame])
				{
					[gridView removeFromSuperview];
					[gridView release];
					gridView = nil;
					
					gridView = [self drawGrid:grids[row][col]];
					gridX = row;
					gridY = col;
				}
				else if (gridView != nil)
				{
					// Same location, do nothing.
				}
				else 
				{
					gridView = [self drawGrid:grids[row][col]];
					gridX = row;
					gridY = col;
				}
			}
			else		// finger moved out of the field, remove the white grid view.
			{
				if (gridView != nil)
				{
					[gridView removeFromSuperview];
					[gridView release];
					gridView = nil;
				}
			}
			
			// Move the draggingImage.
			CGRect newFrame = draggingImage.frame;
			newFrame.origin = CGPointMake(touchLocation.x - 30, touchLocation.y - 55.0);
			draggingImage.frame = newFrame;
		}
		else 
		{
			// This is a magic skill.
			switch (selectedUsingSkill)
			{						
				case 1:			// Accurate.
				{
					if (row >= 0 && row <=7 && col >= 0 && col <= 5)
					{
						[currentMagic release];
						currentMagic = nil;
					}
					
					break;
				}
				case 2:			// Corrosion.
				{
					MagicVirus *magicVirus = (MagicVirus *)currentMagic;
					
					if (row >= 0 && row <=7 && col >= 0 && col <= 5)
					{
						magicVirus.ready = YES;
						if (col == 5) 
							magicVirus.startCol = 4;
						else
							magicVirus.startCol = col;
						
						// Move the draggingImage.
						CGRect newFrame = draggingImage.frame;
						newFrame.origin = grids[0][magicVirus.startCol].origin;
						draggingImage.frame = newFrame;
					}
					else 
					{
						magicVirus.ready = NO;
						
						// Move the draggingImage.
						CGRect newFrame = draggingImage.frame;
						newFrame.origin = CGPointMake(touchLocation.x - 51, touchLocation.y - 152);
						draggingImage.frame = newFrame;
					}
					
					break;
				}
				case 7:			// Gold.
				{
					if (row >= 0 && row <=7 && col >= 0 && col <= 5)
					{
						[currentMagic release];
						currentMagic = nil;
					}
					
					break;
				}
				case 8:			// Lava.
				{
					MagicEruption *magicEruption = (MagicEruption *)currentMagic;

					if (row > 0 && row < 7 && col > 0 && col < 5) 
					{
						magicEruption.ready = YES;
						magicEruption.startRow = row - 1;
						magicEruption.startCol = col - 1;
						
						// Move the draggingImage.
						CGRect newFrame = draggingImage.frame;
						newFrame.origin = grids[row-1][col-1].origin;
						draggingImage.frame = newFrame;
					}
					else 
					{
						magicEruption.ready = NO;
						
						// Move the draggingImage.
						CGRect newFrame = draggingImage.frame;
						newFrame.origin = CGPointMake(touchLocation.x - 76, touchLocation.y - 57);
						draggingImage.frame = newFrame;
					}
					
					break;
				}
				case 9:			// Lighting.
				{
					if (row >= 0 && row <=7 && col >= 0 && col <= 5)
					{
						[currentMagic release];
						currentMagic = nil;
					}
					
					break;
				}
				case 13:		// SnowLotus.
				{
					if (row >= 0 && row <=7 && col >= 0 && col <= 5)
					{
						[currentMagic release];
						currentMagic = nil;
					}
					
					break;
				}
				case 14:		// Thorn.
				{
					MagicThorn *magicThorn = (MagicThorn *)currentMagic;
					
					if (row >= 0 && row <= 7 && col >= 0 && col <= 5 && battleFieldUnits[row][col] != nil) 
					{
						magicThorn.ready = YES;
						[magicThorn setUnit:battleFieldUnits[row][col]];
						
						// Move the draggingImage.
						draggingImage.frame = battleFieldUnits[row][col].currentImageView.frame;
					}
					else 
					{
						magicThorn.ready = NO;
						
						// Move the draggingImage.
						CGRect newFrame = draggingImage.frame;
						newFrame.origin = CGPointMake(touchLocation.x - 25, touchLocation.y - 55);
						draggingImage.frame = newFrame;
					}
					
					break;
				}
				case 15:		// Treatment.
				{
					if (row >= 0 && row <=7 && col >= 0 && col <= 5)
					{
						[currentMagic release];
						currentMagic = nil;
					}
					
					break;
				}
				default:
					break;
			}
		}
	}
}

// Return the number indicating the stage element.
// Return -1 for arena.
- (int)getStageElement
{
	int currentGameStage = [GameUtils getCurrentGameStage];
		
	if (currentGameStage <= 4)
		return 1;
	else if (currentGameStage <= 9)
		return 2;
	else if (currentGameStage <= 14)
		return 3;
	else if (currentGameStage <= 19)
		return 4;
	else 
		return -1;
}

// Make the current magic skill unavailable.
// Also update the magic.
- (void)makeMagicSkillUnavailable
{
	// Make it unavailable and put on the masking view.
	skills[currentSkillNumber].isAvailable = NO;
	[self.view addSubview:skills[currentSkillNumber].availablityView];
		
	// Update the magic.
	[self updateMagic:currentMagic.magicCost];
}

// For player interaction.
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{	
	if (currentMagic != nil && magic >= currentMagic.magicCost)
	{
		// Put the first animation of the magic on the field.
		
		switch (selectedUsingSkill)
		{						
			case 1:			// Accurate.
			{
				[self makeMagicSkillUnavailable];

				magicSpells ++;
				
				[currentMagic release];
				currentMagic = nil;
				
				// Create one for each enemy on the field.
				NSEnumerator *m;
				m = [enemiesOnField objectEnumerator];
				EnemyUnit *enemyUnitOnField;
				while (enemyUnitOnField = [m nextObject])
				{
					// Lock the enemy, 1 indicates locked.
					[enemyUnitOnField setCondition:1 withBoolean:YES];
					
					MagicTarget *magicTarget = [[MagicTarget alloc] initWithEnemy:enemyUnitOnField];
					
					// Need to move it according to the enemy's position.
					CGRect frame = enemyUnitOnField.currentImageView.frame;
					frame.origin.y += 15;
					magicTarget.currentImageView.frame = frame;
										
					[enemyUnitOnField.currentImageView removeFromSuperview];
					[self.view addSubview:magicTarget.currentImageView];
					[self.view addSubview:enemyUnitOnField.currentImageView];
					
					[lowerMagicArray addObject:magicTarget];
					
					[magicTarget release];
				}
								
				break;
			}
			case 2:			// Corrosion.
			{
				MagicVirus *magicVirus = (MagicVirus *)currentMagic;
				
				if (magicVirus.ready)
				{
					CGRect frame = draggingImage.frame;
					magicVirus.currentImageView.frame = frame;
					
					[self.view addSubview:magicVirus.currentImageView];
					
					// Update the damage grids.
					for (int i = 0; i < 8; i ++)
					{
						damageGrids[i][magicVirus.startCol] += magicVirus.attack;
						damageGrids[i][magicVirus.startCol+1] += magicVirus.attack;
					}
					
					[self makeMagicSkillUnavailable];
					
					magicSpells ++;

					[lowerMagicArray addObject:magicVirus];
					[currentMagic release];
					currentMagic = nil;					
				}
				else 
				{
					[currentMagic release];
					currentMagic = nil;
				}

				break;
			}
			case 7:			// Gold.
			{
				MagicGold *magicGold = (MagicGold *)currentMagic;
				
				[self.view addSubview:magicGold.currentImageView];
				
				[self makeMagicSkillUnavailable];

				magicSpells ++;
				
				[lowerMagicArray addObject:magicGold];
				[currentMagic release];
				currentMagic = nil;
				
				break;
			}
			case 8:			// Lava.
			{
				MagicEruption *magicEruption = (MagicEruption *)currentMagic;
				
				if (magicEruption.ready)
				{
					CGRect frame = draggingImage.frame;
					magicEruption.currentImageView.frame = frame;
					
					[self.view addSubview:magicEruption.currentImageView];
					
					// Update the damage grids.
					for (int i = 0; i < 3; i ++)
					{
						for (int j = 0; j < 3; j ++)
						{
							damageGrids[magicEruption.startRow+i][magicEruption.startCol+j] += magicEruption.attack;
						}
					}
					
					[self makeMagicSkillUnavailable];

					magicSpells ++;
					
					[lowerMagicArray addObject:magicEruption];
					[currentMagic release];
					currentMagic = nil;					
				}
				else
				{
					[currentMagic release];
					currentMagic = nil;
				}
				
				break;
			}
			case 9:			// Lighting.
			{
				[self makeMagicSkillUnavailable];

				magicSpells ++;
				
				[currentMagic release];
				currentMagic = nil;
				
				// Create one for each soldier and heal each one of them.
				for (int row = 0; row < 8; row ++)
				{
					for (int col = 0; col < 6; col ++)
					{
						Skill *curSkill = battleFieldUnits[row][col];
						
						// Cannot increase attack point of fence.
						if (curSkill != nil && curSkill.skillNumber != 16 && curSkill.isDying == NO)
						{
							MagicHolyLight *magicHoldLight = [[MagicHolyLight alloc] initWithAffectingUnit:curSkill];
							magicHoldLight.currentImageView.frame = curSkill.currentImageView.frame;
							
							[self.view addSubview:magicHoldLight.currentImageView];
							[upperMagicArray addObject:magicHoldLight];
							
							[magicHoldLight release];
							
							// Increase the attack point.
							curSkill.attack *= 2;
						}
					}
				}
								
				break;
			}
			case 13:		// SnowLotus.
			{
				[self makeMagicSkillUnavailable];

				magicSpells ++;
				
				[currentMagic release];
				currentMagic = nil;
				
				// Create one for each enemy on the field.
				NSEnumerator *m;
				m = [enemiesOnField objectEnumerator];
				EnemyUnit *enemyUnitOnField;
				while (enemyUnitOnField = [m nextObject])
				{
					// Freeze the enemy, 0 indicates freeze.
					[enemyUnitOnField setCondition:0 withBoolean:YES];
					
					MagicSnowLotus *magicSnowLotus = [[MagicSnowLotus alloc] initWithAffectingEnemy:enemyUnitOnField];
					magicSnowLotus.currentImageView1.frame = enemyUnitOnField.currentImageView.frame;
					magicSnowLotus.currentImageView2.frame = enemyUnitOnField.currentImageView.frame;
					
					[enemyUnitOnField.currentImageView removeFromSuperview];
					
					[self.view addSubview:magicSnowLotus.currentImageView1];
					[self.view addSubview:enemyUnitOnField.currentImageView];
					[self.view addSubview:magicSnowLotus.currentImageView2];
					
					[lowerMagicArray addObject:magicSnowLotus];
					
					[magicSnowLotus release];
				}
				
				break;
			}
			case 14:		// Thorn.
			{
				MagicThorn *magicThorn = (MagicThorn *)currentMagic;
				
				if (magicThorn.ready)
				{
					CGRect frame = draggingImage.frame;
					magicThorn.frontImageView.frame = frame;
					magicThorn.backImageView.frame = frame;
					[[magicThorn getUnit].currentImageView removeFromSuperview];
					
					[self.view addSubview:magicThorn.backImageView];
					[self.view addSubview:[magicThorn getUnit].currentImageView];
					[self.view addSubview:magicThorn.frontImageView];
					
					// Mark the unit as protected.
					[magicThorn getUnit].isProtected = YES;
					
					[self makeMagicSkillUnavailable];

					magicSpells ++;
					
					[upperMagicArray addObject:magicThorn];
					[currentMagic release];
					currentMagic = nil;					
				}
				else
				{
					[currentMagic release];
					currentMagic = nil;
				}
				
				break;
			}
			case 15:		// Treatment.
			{
				[self makeMagicSkillUnavailable];

				magicSpells ++;
				
				[currentMagic release];
				currentMagic = nil;
				
				// Create one for each soldier and heal each one of them.
				for (int row = 0; row < 8; row ++)
				{
					for (int col = 0; col < 6; col ++)
					{
						Skill *curSkill = battleFieldUnits[row][col];
						
						// Cannot heal fence.
						if (curSkill != nil && curSkill.skillNumber != 16 && curSkill.isDying == NO)
						{
							MagicTreatment *magicTreatment = [[MagicTreatment alloc] init];
							magicTreatment.currentImageView.frame = curSkill.currentImageView.frame;
							
							[self.view addSubview:magicTreatment.currentImageView];
							[upperMagicArray addObject:magicTreatment];
							
							[magicTreatment release];
							
							// Add health to make it full.
							[curSkill reduceHealthBy:curSkill.health - curSkill.totalHealth];
						}
					}
				}
								
				break;
			}
			default:
				break;
		}
	}
	else if (draggingImage != nil && currentMagic == nil && gridView != nil && battleFieldUnits[gridX][gridY] == nil)
	{
#pragma mark Put Down Unit

		// Put the base unit image on the field if it's possible.

		if (money >= skills[currentSkillNumber].amount)
		{
			// Make it unavailable and put on the masking view.
			skills[currentSkillNumber].isAvailable = NO;
			[self.view addSubview:skills[currentSkillNumber].availablityView];
			
			battleFieldUnits[gridX][gridY] = [skills[currentSkillNumber] mutableCopy];
			Skill *tempSkill = battleFieldUnits[gridX][gridY];
			[tempSkill setCurrentImageViewTo:tempSkill.baseImage];
			CGRect newFrame = tempSkill.currentImageView.frame;
			newFrame.origin = CGPointMake(grids[gridX][gridY].origin.x, grids[gridX][gridY].origin.y - 16);
			tempSkill.currentImageView.frame = newFrame;
			
			[self.view addSubview:tempSkill.currentImageView];
			
			// Check if this is moon soldier.
			if (tempSkill.skillNumber == 11)
			{
				moonPowerModifier += 0.1;
			}
			
			// Add the health bar to the field.
			newFrame = tempSkill.healthOutletView.frame;
			newFrame.origin = CGPointMake(grids[gridX][gridY].origin.x + 6, grids[gridX][gridY].origin.y - 20);
			tempSkill.healthOutletView.frame = newFrame;
			newFrame = tempSkill.healthImageView.frame;
			newFrame.origin = CGPointMake(grids[gridX][gridY].origin.x + 7, grids[gridX][gridY].origin.y - 19);
			tempSkill.healthImageView.frame = newFrame;
			
			[self.view addSubview:tempSkill.healthImageView];
			[self.view addSubview:tempSkill.healthOutletView];
			
			// Update the money.
			unsigned int newMoney = money - tempSkill.amount;
			[self updateMoney:newMoney];
			
			recruits ++;
			
			// See if this unit has same element as the stage.
			if ([self getStageElement] == tempSkill.element)
			{
				// See if this unit is on any of the special fields.
				NSEnumerator *m;
				m = [specialFields objectEnumerator];
				UIImageView *specialFieldImageView;
				while (specialFieldImageView = [m nextObject])
				{
					if ([GameUtils compareCGRect:specialFieldImageView.frame isSameAs:gridView.frame])
					{
						switch (specialFieldIndicator)
						{
							case 0:			// Attack.
								tempSkill.attack = tempSkill.attack * (1 + GROUND_FIXING);
								break;
							case 1:			// Health.
								tempSkill.health = tempSkill.health * (1 + GROUND_FIXING);
								tempSkill.totalHealth = tempSkill.totalHealth * (1 + GROUND_FIXING);
								break;
							case 2:			// Dodge rate.
								tempSkill.dodgeRate = tempSkill.dodgeRate * (1 + GROUND_FIXING);
								break;
							case 3:			// Attack frequency.
								tempSkill.attackFrequency = tempSkill.attackFrequency * (1 + GROUND_FIXING);
								break;
							default:
								break;
						}
						
						break;
					}
				}
				
			}
		}
	}
		
	// Re-set the dragging image.
	if (draggingImage != nil)
	{
		[draggingImage removeFromSuperview];
		[draggingImage release];
		draggingImage = nil;
	}
	
	// Clear the dragging grid view.
	if (gridView != nil)
	{
		[gridView removeFromSuperview];
		
		[gridView release];
		gridView = nil;
	}
	
	// Double check.
	if (currentMagic != nil)
	{
		[currentMagic release];
		currentMagic = nil;
	}
}

// Update player's health information.
// The minimum health is 0.
- (void)updateHealth:(float)healthPointTaken
{
	health -= healthPointTaken;
	
	if (health < 0)
	{
		health = 0;
	}
	
	NSString *healthString = [NSString stringWithFormat:@"%d/100", (int)health];
	healthLabel.text = healthString;
	CGRect frame = healthImage.frame;
	frame.size.width = 104 * health / MAX_HEALTH;
	healthImage.frame = frame;
}

// Update player's magic information.
- (void)updateMagic:(float)magicPointTaken
{
	UserInformation *UInfo = [UserInformation sharedManager];
	
	magic -= magicPointTaken;
	if (magic > UInfo.maxMagic)
		magic = UInfo.maxMagic;
	
	NSString *magicString = [NSString stringWithFormat:@"%d/%d", (int)magic, UInfo.maxMagic];
	magicLabel.text = magicString;
	CGRect frame = magicImage.frame;
	frame.size.width = 104 * magic / UInfo.maxMagic;
	magicImage.frame = frame;
}

// Update player's money amount.
- (void)updateMoney:(unsigned int)newMoney
{
	if (newMoney > MAX_MONEY)
		newMoney = MAX_MONEY;
	
	money = newMoney;
	
	NSString *moneyString = [NSString stringWithFormat:@"%u", newMoney];
	moneyLabel.text = moneyString;
}

// Update the number of enemies left.
- (void)updateEnemiesNumber:(int)newNumber
{
	NSString *enemiesNumberString = [NSString stringWithFormat:@"%d", newNumber];
	numberOfEnemiesLabel.text = enemiesNumberString;
}

// Draw a rectangle shape on the view.
// Caller needs to free the UIView memory.
- (UIView *)drawGrid:(CGRect)rect
{
	UIView *view = [[UIView alloc] initWithFrame:rect];
	view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
	
	[self.view addSubview:view];
	return view;
}

// Initialize the grids on the battle field.
- (void)initializeGrids
{
#define GRID_WIDTH 51
#define GRID_HEIGHT 38
#define UPPER_LEFT_X 7
#define UPPER_LEFT_Y 40
	// Set the grids coordinates.
	for (int i = 0; i < 8; i++)
	{
		for (int j = 0; j < 6; j++)
		{
			grids[i][j].origin.x = UPPER_LEFT_X + j * GRID_WIDTH;
			grids[i][j].origin.y = UPPER_LEFT_Y + i * GRID_HEIGHT;
			grids[i][j].size.width = GRID_WIDTH;
			grids[i][j].size.height = GRID_HEIGHT;
			
			// Initially no grids does damage.
			damageGrids[i][j] = 0.0;
		}
	}
	
	// Set the special fields.
	int currentGameStage = [GameUtils getCurrentGameStage];
	
	int totalSpecialFields = (currentGameStage % 5) + 1;
	
	if (currentGameStage == 20)		// The arena
		totalSpecialFields = 0;
	
	NSString *imageName;
	if (currentGameStage <= 4)
		imageName = [NSString stringWithString:@"ES_GameEnv_FactorOnMap_Earth.png"];
	else if (currentGameStage <= 9)
		imageName = [NSString stringWithString:@"ES_GameEnv_FactorOnMap_Air.png"];
	else if (currentGameStage <= 14)
		imageName = [NSString stringWithString:@"ES_GameEnv_FactorOnMap_Water.png"];
	else 
		imageName = [NSString stringWithString:@"ES_GameEnv_FactorOnMap_Fire.png"];

	specialFields = [[NSMutableArray alloc] initWithCapacity:totalSpecialFields];
	
	for (int i = 0; i < totalSpecialFields; i++)
	{
		int location = arc4random() % 48;
		
		UIImageView *specialView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
		
		specialView.frame = grids[0][location];
		
		// Save it in an array for deletion later.
		[specialFields addObject:specialView];
		
		[self.view addSubview:specialView];
		
		[specialView release];
	}
}

// Initialize the enemy array according to the stage number.
- (void)initializeEnemiesForArena
{	
	NSString *enemiesNumberString = [NSString stringWithString:@"???"];
	numberOfEnemiesLabel.text = enemiesNumberString;
	
	enemiesOnField = [[NSMutableArray alloc] initWithCapacity:18];
	enemiesOnHPBar = [[NSMutableArray alloc] initWithCapacity:3];
	enemyArray = [[NSMutableArray alloc] initWithCapacity:100];
	
	for (int i = 0; i < 100; i++)
	{
		// Randomly choose an enemy.
		int enemyNumber = (arc4random() % 12) + 1;
		
		EnemyUnit *veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:enemyNumber];
		
		// Put it in the array.
		[enemyArray addObject:veryTempEnemyUnit];
		
		[veryTempEnemyUnit release];
	}
}

// Used for arena stage, assume everything else has been initialized.
- (void)putMoreEnemiesInArray
{
	// Put 100 more enemies into the array.
	for (int i = 0; i < 100; i++)
	{
		// Randomly choose an enemy.
		int enemyNumber = (arc4random() % 12) + 1;
		
		EnemyUnit *veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:enemyNumber];
		
		// Put it in the array.
		[enemyArray addObject:veryTempEnemyUnit];
		
		[veryTempEnemyUnit release];
	}
}

// Initialize the enemy array according to the stage number.
- (void)initializeEnemies
{
	// Get the current stage number.
	const int stageNumber = [GameUtils getCurrentGameStage];
	
	// Element: 0 means earth, 1 means air, 2 means water, 3 means fire.
	const int element = stageNumber / 5;
	
	const int level =  stageNumber - element * 5;
	int totalEnemiesNumber;
	int firstKindCut;
	int secondKindCut;
	
	// Set the total enemies number.
	switch (level)
	{
		case 0:
			totalEnemiesNumber = 100;
			firstKindCut = 100 * 0.90;
			secondKindCut = 100;
			break;
		case 1:
			totalEnemiesNumber = 110;
			firstKindCut = 100 * 0.70;
			secondKindCut = 100 * 0.90;
			break;
		case 2:
			totalEnemiesNumber = 120;
			firstKindCut = 100 * 0.50;
			secondKindCut = 100 * 0.80;
			break;
		case 3:
			totalEnemiesNumber = 130;
			firstKindCut = 100 * 0.30;
			secondKindCut = 100 * 0.70;
			break;
		case 4:
			totalEnemiesNumber = 140;
			firstKindCut = 100 * 0.10;
			secondKindCut = 100 * 0.60;
			break;
		default:
			break;
	}

	numberOfEnemies = totalEnemiesNumber;
	[self updateEnemiesNumber:numberOfEnemies];
	
	enemiesOnField = [[NSMutableArray alloc] initWithCapacity:18];
	enemiesOnHPBar = [[NSMutableArray alloc] initWithCapacity:3];
	enemyArray = [[NSMutableArray alloc] initWithCapacity:totalEnemiesNumber];
	
	for (int i = 0; i < totalEnemiesNumber; i++)
	{
		// Randomly choose a type.
		int a = arc4random() % 100;
		
		EnemyUnit *veryTempEnemyUnit;
		switch (element)
		{
			case 0:									// Earth.
				if (a >= secondKindCut) 
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:6];
				}
				else if (a >= firstKindCut)
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:5];
				}
				else
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:4];
				}
				break;
			case 1:									// Air.
				if (a >= secondKindCut)
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:3];
				}
				else if (a >= firstKindCut)
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:2];
				}
				else 
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:1];
				}
				break;
			case 2:									// Water.
				if (a >= secondKindCut)
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:12];
				}
				else if (a >= firstKindCut)
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:11];
				}
				else 
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:10];
				}
				break;
			case 3:									// Fire.
				if (a >= secondKindCut)
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:9];
				}
				else if (a >= firstKindCut)
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:8];
				}
				else 
				{
					veryTempEnemyUnit = [[EnemyUnit alloc] initWithEnemyNumber:7];
				}
				break;
			default:
				break;
		}
		
		// Put it in the array.
		[enemyArray addObject:veryTempEnemyUnit];
		[veryTempEnemyUnit release];
	}
}

// Decide the speical ground fixing.
- (void)initializeGroundFixing
{
	// First decide which parameter to increase.
	// attack, health, dodge rate, attack frequency.
	
	int currentStage = [GameUtils getCurrentGameStage];
	
	if (currentStage != 20)		// Not arena.
	{
		specialFieldIndicator = arc4random() % 4;
		
		NSString *labelString;
		
		switch (specialFieldIndicator)
		{
			case 0:
				labelString = [NSString stringWithString:@"Atk+20%"];
				break;
			case 1:
				labelString = [NSString stringWithString:@"Hth+20%"];
				break;
			case 2:
				labelString = [NSString stringWithString:@"Dge+20%"];
				break;
			case 3:
				labelString = [NSString stringWithString:@"Fqc+20%"];
				break;
			default:
				break;
		}
		
		specialFieldLabel.text = labelString;
	}
	else		// Arena.
	{
		specialFieldLabel.text = [NSString stringWithString:@""];
	}
}

- (AVPlaybackSoundController *)theBGMObject
{
	id theDelegate = [UIApplication sharedApplication].delegate;
	AVPlaybackSoundController *theBGMController;
	theBGMController = ((Elemental_SymphonyAppDelegate *)theDelegate).avPlaybackSoundController;
	return theBGMController;
}

// Start to play the BGM.
- (void)startMusic
{
	AVPlaybackSoundController *BGMController = [self theBGMObject];
	[BGMController playFromTop];
}

// Initialize the game, should be called before a new game starts.
- (void)initializeGame
{
	UserInformation *UInfo = [UserInformation sharedManager];
		
	health = 100.0;
	[self updateHealth:0.0];
	magic = UInfo.maxMagic;
	[self updateMagic:0.0];
	if ([GameUtils getCurrentGameStage] == 20)
	{
		[self updateMoney:ARENA_MONEY];	// This method will set money variable.
	}
	else
	{
		[self updateMoney:UInfo.money];	// This method will set money variable.
	}
	
	int *skillsList = (int *)malloc(sizeof(int) * 6);
	for (int i = 0; i < 6; ++i)
	{
		skillsList[i] = [UInfo usingSkills:i];
	}
	[self initializeSkills:skillsList];
	free(skillsList);
	
	// Initialize miss image view array.
	missingArray = [[NSMutableArray alloc] initWithCapacity:2];
	
	// Initialize the bullet array.
	bulletArray = [[NSMutableArray alloc] initWithCapacity:12];
	
	// Initialize the magic array.
	lowerMagicArray = [[NSMutableArray alloc] initWithCapacity:3];
	upperMagicArray = [[NSMutableArray alloc] initWithCapacity:3];
	
	// Initialize the grids on the field.
	[self initializeGrids];
	
	// Initialize for special ground.
	[self initializeGroundFixing];
	
	// Initialize the enemies.
	if ([GameUtils getCurrentGameStage] != 20)
	{
		[self initializeEnemies];
	}
	else 
	{
		[self initializeEnemiesForArena];	
	}
	
	// Start game by initialize the timer.
	[self initializeTimer];
	
	// Clear them to be false.
	for (int i = 0; i < 6; ++i)
	{
		enemiesInLane[i] = NO;
	}
	
	// Other initialization.
	moonPowerModifier = 1.0;
	currentMagic = nil;
	enemyCounter = 0;
	numberOfEnemiesKilled = 0;
	recruits = 0;
	magicSpells = 0;
	sortingCounter = 0;
	enemyFrequency = 90;		// 90 indicates 3 seconds.
	
	// Start playing BGM.
	[self startMusic];
}

// Initialize the skills list.
- (void)initializeSkills:(int *)skillNumbers
{
	for (int i = 0; i < 6; i++)
	{
		// Create the skill according to the skill number.
		skills[i] = [[Skill alloc] initWithSkillNumber:skillNumbers[i]];
		
		// Put it to the right location on the view.
		CGRect newFrame = skills[i].skillImage.frame;
		newFrame.origin = CGPointMake(8 + i * 52, 359);
		skills[i].skillImage.frame = newFrame;
		skills[i].availablityView.frame = newFrame;
		
		[self.view addSubview:skills[i].skillImage];
		
		// Display the following things only if the skill is not NONE, e.g. skill 0.
		if (skillNumbers[i] != 0)
		{
			// Put small icon image to the right location.
			CGRect iconFrame = skills[i].smallImage.frame;
			iconFrame.origin = CGPointMake(8 + i * 52, 405);
			skills[i].smallImage.frame = iconFrame;
			
			[self.view addSubview:skills[i].smallImage];
			
			// Display the right amount.
			switch (i) 
			{
				case 0:
					firstAmount.text = [NSString stringWithFormat:@"%d", skills[i].amount];
					break;
				case 1:
					secondAmount.text = [NSString stringWithFormat:@"%d", skills[i].amount];
					break;
				case 2:
					thirdAmount.text = [NSString stringWithFormat:@"%d", skills[i].amount];
					break;
				case 3:
					fourthAmount.text = [NSString stringWithFormat:@"%d", skills[i].amount];
					break;
				case 4:
					fifthAmount.text = [NSString stringWithFormat:@"%d", skills[i].amount];
					break;
				case 5:
					sixthAmount.text = [NSString stringWithFormat:@"%d", skills[i].amount];
					break;
				default:
					break;
			}
			
		}
	}
}

// Initialize the timer for the game.
- (void)initializeTimer
{
	isPlaying = YES;
	
	if(theTimer == nil)
	{
		float theInterval = 1.0 / 30.0;
		
		theTimer = [NSTimer scheduledTimerWithTimeInterval:theInterval 
													target:self 
												  selector:@selector(gameLogic:) 
												  userInfo:nil 
												   repeats:YES];
	}
}

// Pause the game for various reasons.
- (void)pauseGame
{
	isPlaying = NO;
	
	[theTimer invalidate];
	theTimer = nil;
}

// Resume the game, called after calling to pauseGame().
- (void)resumeGame
{
	[self initializeTimer];
}

// Called when game ends, release objects used in the game.
- (void)gameEnded
{
	isPlaying = NO;
	
	// Stop the timer.
	[theTimer invalidate];
	theTimer = nil;

	// Delete skill list.
	for (int i = 0; i < 6; i++)
	{
		[skills[i].skillImage removeFromSuperview];
		[skills[i].smallImage removeFromSuperview];
		[skills[i].availablityView removeFromSuperview];
		
		[skills[i] release];
	}
	
	// Delete special fields.
	NSEnumerator *specialFieldEnumerator = [specialFields objectEnumerator];
	UIImageView *curSpecialField;
	while (curSpecialField = [specialFieldEnumerator nextObject])
	{
		[curSpecialField removeFromSuperview];
	}
	[specialFields release];
	
	// Delete all the units on the battle field.
	for (int i = 0; i < 8; ++ i)
		for (int j = 0; j < 6; ++ j)
			if (battleFieldUnits[i][j] != nil)
			{
				[battleFieldUnits[i][j].currentImageView removeFromSuperview];
				[battleFieldUnits[i][j].healthOutletView removeFromSuperview];
				[battleFieldUnits[i][j].healthImageView removeFromSuperview];
				[battleFieldUnits[i][j].dyingImageView removeFromSuperview];
				
				[battleFieldUnits[i][j] release];
				battleFieldUnits[i][j] = nil;
			}
	
	// Delete all the bullets still on the field.
	NSEnumerator *bulletEnumerator = [bulletArray objectEnumerator];
	Bullet *curBullet;
	while (curBullet = [bulletEnumerator nextObject])
	{
		[curBullet.bulletView removeFromSuperview];
	}
	[bulletArray release];
	
	// Delete all the magic still on the field.
	[lowerMagicArray release];
	[upperMagicArray release];
	
	// Delete all the missing image.
	NSEnumerator *missingEnumerator = [missingArray objectEnumerator];
	AttackMissView *curMissView;
	while (curMissView = [missingEnumerator nextObject])
	{
		[curMissView.currentImageView removeFromSuperview];
	}
	[missingArray release];
	
	// Delete the dragging image.
	if (draggingImage != nil)
	{
		[draggingImage removeFromSuperview];
		[draggingImage release];
		draggingImage = nil;
	}
	
	// Delete the magic object possibly allocated.
	if (currentMagic != nil) 
	{
		[currentMagic release];
	}
	
	// Delete the grid view.
	if (gridView != nil)
	{
		[gridView removeFromSuperview];
		[gridView release];
		gridView = nil;
	}
	
	// Delete the enemies array.
	[enemyArray release];
	
	NSEnumerator *enemyFieldEnumertor = [enemiesOnField objectEnumerator];
	EnemyUnit *curEnemy;
	while (curEnemy = [enemyFieldEnumertor nextObject])
	{
		[self removeEnemyFromField:curEnemy];
	}
	[enemiesOnField release];
	
	NSEnumerator *enemyHPEnumerator = [enemiesOnHPBar objectEnumerator];
	while (curEnemy = [enemyHPEnumerator nextObject])
	{
		[self removeEnemyFromField:curEnemy];
	}
	[enemiesOnHPBar release];
	
	// End the music.
	AVPlaybackSoundController *BGMController = [self theBGMObject];
	[BGMController stopPlayer];
}

// Switch view to see arena score.
- (void)switchViewToArenaScore
{	
	if(arenaScoreViewController == nil)
	{
		Elemental_SymphonyArenaScoreViewController *arenaController = [[Elemental_SymphonyArenaScoreViewController alloc] initWithNibName:@"Elemental_SymphonyArenaScoreViewController" bundle:nil];
		self.arenaScoreViewController = arenaController;
		[arenaController release];
	}
	
	// Set the record variables.
	arenaScoreViewController.kills = numberOfEnemiesKilled;
	arenaScoreViewController.recruits = recruits;
	arenaScoreViewController.magic = magicSpells;
	arenaScoreViewController.gold = money;
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
		
	[self presentModalViewController:arenaScoreViewController animated:YES];
}

// Switch view to prize view.
- (void)switchViewToPrizeView
{
	if(prizeViewController == nil)
	{
		Elemental_SymphonyPrizeViewController *prizeController = [[Elemental_SymphonyPrizeViewController alloc] initWithNibName:@"Elemental_SymphonyPrizeViewController" bundle:nil];
		self.prizeViewController = prizeController;
		[prizeController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
		
	[self presentModalViewController:prizeViewController animated:YES];
}

// Switch view to game over.
- (void)switchViewToGameOver
{	
	if(gameOverViewController == nil)
	{
		Elemental_SymphonyGameOverViewController *gameOverController = [[Elemental_SymphonyGameOverViewController alloc] initWithNibName:@"Elemental_SymphonyGameOverViewController" bundle:nil];
		self.gameOverViewController = gameOverController;
		[gameOverController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	// Set the animation.
	gameOverViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	
	[self presentModalViewController:gameOverViewController animated:YES];
}

// Add an enemy unit to the battle field, including its health bar.
// This method assumes the image view is already in the correct position.
- (void)addEnemyUnitToTheView:(EnemyUnit *)enemyUnit
{
	[self.view addSubview:enemyUnit.currentImageView];
	[self.view addSubview:enemyUnit.healthImageView];
	[self.view addSubview:enemyUnit.healthOutletView];
	if (enemyUnit.conditionImageView.image != nil)
	{
		[self.view addSubview:enemyUnit.conditionImageView];
	}
}

// Remove enemy's views from the field.
// Including enemy and enemy's health bar.
- (void)removeEnemyFromField:(EnemyUnit *)enemy
{
	if (enemy.conditionImageView.image != nil)
	{
		[enemy.conditionImageView removeFromSuperview];
	}
	[enemy.healthImageView removeFromSuperview];
	[enemy.healthOutletView removeFromSuperview];
	[enemy.currentImageView removeFromSuperview];
}

// Let a particular enemy attack the HP bar.
- (void)makeEnemyAttackHPBar:(EnemyUnit *)enemy
{	
	[enemy switchToAttackMode];
	
	// Put the enemy in the right position to attach the HP bar.
	CGRect newFrame = enemy.currentImageView.frame;
	newFrame.origin.x = 135;
	newFrame.origin.y = 380;
	enemy.currentImageView.frame = newFrame;
	
	// Add the image back to the screen.
	[self.view addSubview:enemy.currentImageView];
}

// Method that contains the logic of the game.
// The frequency of this method is currently set to 30 times per second.
- (void)gameLogic:(NSTimer *)timer
{
	int gameStage = [GameUtils getCurrentGameStage];

	// Check if player is dead.
	if (health <= 0)
	{
		UserInformation *UInfo = [UserInformation sharedManager];

		if (gameStage == 20)	// Arena.
		{
			// Update record variables.
			UInfo.numberKilled += numberOfEnemiesKilled;
		}
		else
		{
			// Update record variables.
			UInfo.numberDeath ++;
			
			[GameUtils saveTheGame];
		}
		
		// End the game.
		[self gameEnded];
		
		// TODO: Player is dead, play the ending music.
		sleep(3);
		
		if (gameStage == 20)	// Arena.
		{
			// Display the arena score view.
			[self switchViewToArenaScore];
		}
		else
		{
			// Display the game over view.
			[self switchViewToGameOver];
		}
		
		return;
	}
	
	// Check if there are still enemies, if not, then player wins.
	if (numberOfEnemies == 0 && gameStage != 20)
	{
		// Update record variables.
		UserInformation *UInfo = [UserInformation sharedManager];
		UInfo.money = money;
		UInfo.numberKilled += numberOfEnemiesKilled;
		
		// End the game.
		[self gameEnded];
						
		// Go to prize view.
		[self switchViewToPrizeView];
		
		return;
	}
	
	// For arena only.
	if (gameStage == 20 && [enemyArray count] == 0)
	{
		[self putMoreEnemiesInArray];
	}
	
	// Iterate throught 6 skills.
	for (int i = 0; i < 6; ++i)
	{
		if (! skills[i].isAvailable)
		{
			[skills[i] tryToMakeAvailable];
		}
	}
	
#pragma mark Lower Magic

	// Iterate through all the lower magic in effect.
	NSMutableIndexSet *lowerMagicIndexToRemove = [NSMutableIndexSet indexSet];
	NSUInteger index = 0;
	NSEnumerator *magicEnumerator = [lowerMagicArray objectEnumerator];
	MagicBaseClass *curMagic;
	while (curMagic = [magicEnumerator nextObject])
	{
		if ([curMagic isKindOfClass:[MagicGold class]])
		{
			MagicGold *magicGold = (MagicGold *)curMagic;
			if ([magicGold displayNextAnimation])
			{				
				// Update the health and the money.
				[self updateHealth:magicGold.hpReduced];
				[self updateMoney:money + magicGold.goldAdded];
								
				[lowerMagicIndexToRemove addIndex:index];
			}
		}
		else if ([curMagic isKindOfClass:[MagicEruption class]])
		{
			MagicEruption *magicEruption = (MagicEruption *)curMagic;
			if ([magicEruption displayNextAnimation]) 
			{				
				// Update the damage grids.
				for (int i = 0; i < 3; i ++)
				{
					for (int j = 0; j < 3; j ++)
					{
						damageGrids[magicEruption.startRow+i][magicEruption.startCol+j] -= magicEruption.attack;
					}
				}
				
				[lowerMagicIndexToRemove addIndex:index];
			}
		}
		else if ([curMagic isKindOfClass:[MagicVirus class]])
		{
			MagicVirus *magicVirus = (MagicVirus *)curMagic;
			if ([magicVirus displayNextAnimation])
			{				
				// Update the damage grids.
				for (int i = 0; i < 8; i ++)
				{
					damageGrids[i][magicVirus.startCol] -= magicVirus.attack;
					damageGrids[i][magicVirus.startCol + 1] -= magicVirus.attack;
				}
				
				[lowerMagicIndexToRemove addIndex:index];
			}
		}
		else if ([curMagic isKindOfClass:[MagicSnowLotus class]])
		{
			MagicSnowLotus *magicSnowLotus = (MagicSnowLotus *)curMagic;
			
			// Dead.
			if ([magicSnowLotus getAffectingEnemy].health <= 0)
			{				
				[lowerMagicIndexToRemove addIndex:index];				
			}
			else if ([magicSnowLotus displayNextAnimation])
			{				
				[lowerMagicIndexToRemove addIndex:index];
				
				// De-frozen the enemy, 0 indicates freeze.
				[[magicSnowLotus getAffectingEnemy] setCondition:0 withBoolean:NO];
			}
			else
			{
				// Need to display this enemy to the front.
				[magicSnowLotus.currentImageView1 removeFromSuperview];
				[magicSnowLotus.currentImageView2 removeFromSuperview];
				[self removeEnemyFromField:[magicSnowLotus getAffectingEnemy]];
				
				[self.view addSubview:magicSnowLotus.currentImageView1];
				[self addEnemyUnitToTheView:[magicSnowLotus getAffectingEnemy]];
				[self.view addSubview:magicSnowLotus.currentImageView2];
			}
		}
		else if ([curMagic isKindOfClass:[MagicTarget class]])
		{
			MagicTarget *magicTarget = (MagicTarget *)curMagic;
			
			// Dead or crossed the base line.
			if ([magicTarget getAffectingEnemy].health <= 0 || [magicTarget getAffectingEnemy].currentImageView.frame.origin.y > 300)
			{				
				[lowerMagicIndexToRemove addIndex:index];				
			}
			else if ([magicTarget displayNextAnimation])
			{				
				[lowerMagicIndexToRemove addIndex:index];
				
				// De-target the enemy, 1 indicates locked.
				[[magicTarget getAffectingEnemy] setCondition:1 withBoolean:NO];
			}
			else
			{
				[magicTarget.currentImageView removeFromSuperview];
				[[magicTarget getAffectingEnemy].currentImageView removeFromSuperview];
				
				// Need to move it according to the enemy's position.
				CGRect frame = [magicTarget getAffectingEnemy].currentImageView.frame;
				frame.origin.y += 15;
				magicTarget.currentImageView.frame = frame;
				
				[self.view addSubview:magicTarget.currentImageView];
				[self.view addSubview:[magicTarget getAffectingEnemy].currentImageView];
			}
		}
		
		index ++;
	}
	[lowerMagicArray removeObjectsAtIndexes:lowerMagicIndexToRemove];
	
#pragma mark Put Down New Enemy

	// Put down an enemy every few seconds.
	enemyCounter++;
	
	if (enemyCounter >= enemyFrequency && [enemyArray count] > 0)
	{
		if (gameStage == 20 && enemyFrequency > 30)
		{
			enemyFrequency -= 1;			
		}
		
		enemyCounter = 0;
		
		// Randomly choose a lane from 6 lanes.
		int a = arc4random() % 6;
		
		// Put enemy view on the screen.
		EnemyUnit *enemyUnit = [enemyArray lastObject];
		[enemyUnit retain];
		[enemyArray removeLastObject];
		
		// Set the lane number for this enemy.
		enemyUnit.lane = a;
		
		// Set the enemy view to correct position.
		CGRect newFrame = enemyUnit.currentImageView.frame;
		newFrame.origin = CGPointMake(grids[0][a].origin.x - 5, grids[0][a].origin.y - 50);
		enemyUnit.currentImageView.frame = newFrame;
		
		// Set the position of health bar on the field.
		newFrame = enemyUnit.healthOutletView.frame;
		newFrame.origin = CGPointMake(grids[0][a].origin.x + 6, grids[0][a].origin.y - 52);
		enemyUnit.healthOutletView.frame = newFrame;
		newFrame = enemyUnit.healthImageView.frame;
		newFrame.origin = CGPointMake(grids[0][a].origin.x + 7, grids[0][a].origin.y - 51);
		enemyUnit.healthImageView.frame = newFrame;
		
		// Set the position of the condition view.
		newFrame = CGRectMake(newFrame.origin.x + 29, newFrame.origin.y + 6, 9.0, 9.0);
		enemyUnit.conditionImageView.frame = newFrame;
		
		[self addEnemyUnitToTheView:enemyUnit];
		
		// Update the array.
		[enemiesOnField addObject:enemyUnit];
		[enemyUnit release];
	}
	
	// Sort the enemies on the field array once per second.
	// After sorting, the enemies behind are in the front of the array.
	sortingCounter ++;
	if (sortingCounter == 30)	// 30 indicates 1 second.
	{
		sortingCounter = 0;
		
		[enemiesOnField sortUsingSelector:@selector(comparatorForEnemy:)];
	}
	
	// Reset these before the iterations.
	for (int i = 0; i < 6; ++i)
	{
		enemiesInLane[i] = NO;
	}
	
#pragma mark Move All Enemies

	// Move enemies on the field.
	NSMutableIndexSet *enemyOnFieldIndexesToRemove = [NSMutableIndexSet indexSet];
	NSEnumerator *m = [enemiesOnField objectEnumerator];
	EnemyUnit *enemyUnitOnField;
	index = 0;
	while (enemyUnitOnField = [m nextObject])
	{		
		// Check if the enemy is dead.
		if (enemyUnitOnField.health <= 0)
		{
			// Update leftover enemies only if it's not arena.
			if (gameStage != 20)
			{
				// Update the number of left enemies.
				numberOfEnemies --;
				[self updateEnemiesNumber:numberOfEnemies];
			}
			
			numberOfEnemiesKilled ++;
			
			// Remove enemy from the screen.
			[self removeEnemyFromField:enemyUnitOnField];
			
			[enemyOnFieldIndexesToRemove addIndex:index];
			
			// Add 10 gold and 5 magic for each enemy killed.
			[self updateMoney:money + AWARD_GOLD_PER_ENEMY];
			[self updateMagic:- AWARD_MAGIC_PER_ENEMY];
			
			index ++;
			
			continue;
		}
		
		// Check if the enemy has cross the base line.
		if (enemyUnitOnField.currentImageView.frame.origin.y > 300)
		{
			// Remove enemy from the screen.
			[self removeEnemyFromField:enemyUnitOnField];
			
			// Make this enemy attack the HP bar.
			[self makeEnemyAttackHPBar:enemyUnitOnField];
			
			// Enemy gets to the base line, decrease the life of the player by the right amount.
			[self updateHealth:enemyUnitOnField.attack * 0.20];
			
			// Update the number of left enemies only if it's not arena.
			if (gameStage != 20)
			{
				numberOfEnemies --;
				[self updateEnemiesNumber:numberOfEnemies];
			}
			
			[enemiesOnHPBar addObject:enemyUnitOnField];
			[enemyOnFieldIndexesToRemove addIndex:index];
			
			index ++;
			
			continue;
		}
		
		// See if this enemy is on a damage grid.
		// y starts at 40, each height is 38.
		int enemyRow = (enemyUnitOnField.currentImageView.frame.origin.y + 12) / 38;
		if (damageGrids[enemyRow][enemyUnitOnField.lane] > 0.001)
		{
			[enemyUnitOnField reductHealthBy:damageGrids[enemyRow][enemyUnitOnField.lane]];
		}
		
		// Set the lane boolean.
		if (enemiesInLane[enemyUnitOnField.lane] == NO)
		{
			enemiesInLane[enemyUnitOnField.lane] = YES;
		}
		
		// Increase the conditionCount if there is any.
		if (enemyUnitOnField.conditionCounter != 0)
		{
			enemyUnitOnField.conditionCounter ++;
			
			if (enemyUnitOnField.conditionCounter == SPECIAL_EFFECT_LENGTH)
			{
				[enemyUnitOnField clearUnitConditions];
			}
		}
		
		// Check if the enemy is in condition of fired or poison.
		if ([enemyUnitOnField getCondition:3] || [enemyUnitOnField getCondition:6])
		{
			// Take some hp.
			[enemyUnitOnField reductHealthBy:0.3];
		}
		
		// Check if the enemy is in condition of freeze (by magic spell).
		if ([enemyUnitOnField getCondition:0])
		{
			// 0 indicates freeze. Skip this enemy.
			
			index ++;
			
			continue;
		}
		
		// For putting this enemy to the front.
		[self removeEnemyFromField:enemyUnitOnField];
		
		// See if this enemy is during the attacking mode right now.
		if (enemyUnitOnField.isAttacking)
		{
			// This method will reset isAttacking variable when appropriate.
			[enemyUnitOnField switchToNextAttackAnimation];
			
			[self addEnemyUnitToTheView:enemyUnitOnField];

			index ++;
			
			continue;
		}
		
		// See if this enemy should be attacking.
		Skill *againstUnit = [self getTheUnitInFrontOfThisEnemy:enemyUnitOnField];
		BOOL enemyAbleToAttack = [enemyUnitOnField isAbleToAttack];
		if (againstUnit != nil)
		{
			// Attack if not in condition of dizzy.
			if (enemyAbleToAttack && [enemyUnitOnField getCondition:2] == NO)
			{
				// This enemy should be attacking now.
				[enemyUnitOnField switchToAttackMode];
				
				// See if the unit dodges the attack.
				int dodgeInt = 100 * againstUnit.dodgeRate;
				if ((arc4random() % 100) < dodgeInt)
				{
					// Dodged!
					
					CGPoint ori;
					ori.x = againstUnit.currentImageView.frame.origin.x + 1;
					ori.y = againstUnit.currentImageView.frame.origin.y;
					AttackMissView *missView = [[AttackMissView alloc] initWithLocation:ori];
					[self.view addSubview:missView.currentImageView];
					[missingArray addObject:missView];
					[missView release];
				}
				else if (againstUnit.isProtected == NO)
				{
					// Do damage now.

					double att = [GameUtils attackPointAfterTypeFixing:enemyUnitOnField.element :againstUnit.element :enemyUnitOnField.attack];
					
					// Check if enemy is in condition of weak.
					if ([enemyUnitOnField getCondition:7])
					{
						att /= 1.5;
					}
					
					[againstUnit reduceHealthBy:att];
				}
			}
			
			[self addEnemyUnitToTheView:enemyUnitOnField];

			index ++;
			
			continue;
		}

		double speed = enemyUnitOnField.speed;
		
		// Check if the enemy is in condition of freeze. (by unit)
		if ([enemyUnitOnField getCondition:5])
		{
			speed /= 2;
		}
		
		CGRect newFrame = enemyUnitOnField.currentImageView.frame;
		newFrame.origin.y += speed;
		enemyUnitOnField.currentImageView.frame = newFrame;
		
		newFrame = enemyUnitOnField.healthImageView.frame;
		newFrame.origin.y += speed;
		enemyUnitOnField.healthImageView.frame = newFrame;
		newFrame = enemyUnitOnField.healthOutletView.frame;
		newFrame.origin.y += speed;
		enemyUnitOnField.healthOutletView.frame = newFrame;
		
		newFrame = enemyUnitOnField.conditionImageView.frame;
		newFrame.origin.y += speed;
		enemyUnitOnField.conditionImageView.frame = newFrame;
		
		// Animate the walking.
		[enemyUnitOnField switchToNextWalkingAnimation];
		
		index ++;
		
		[self addEnemyUnitToTheView:enemyUnitOnField];
	}

#pragma mark Move All Enemies On HP Bar

	// Animate the enemies which are attacking the HP bar.
	NSEnumerator *b = [enemiesOnHPBar objectEnumerator];
	EnemyUnit *curEnemyOnHPBar;
	NSMutableIndexSet *hpEnemiesRemoveIndexes = [NSMutableIndexSet indexSet];
	index = 0;
	while (curEnemyOnHPBar = [b nextObject])
	{
		// If the attacking is done:
		if (curEnemyOnHPBar.isAttacking == NO)
		{
			[curEnemyOnHPBar.currentImageView removeFromSuperview];
			
			[hpEnemiesRemoveIndexes addIndex:index];
		}
		else
		{
			[curEnemyOnHPBar switchToNextAttackAnimation];
		}
		
		index ++;
	}
	[enemiesOnHPBar removeObjectsAtIndexes:hpEnemiesRemoveIndexes];
	
#pragma mark Move All Bullets

	// Animate the bullets.
	NSMutableIndexSet *bulletRemoveIndexes = [NSMutableIndexSet indexSet];
	NSEnumerator *e = [bulletArray objectEnumerator];
	Bullet *bullet;
	index = 0;
	while (bullet = [e nextObject])
	{
		// Bullet disappears at end of the screen.
		if (bullet.bulletView.frame.origin.y < 0)
		{
			[bullet.bulletView removeFromSuperview];
			
			[bulletRemoveIndexes addIndex:index];
			
			index ++;
			
			continue;
		}
		
		// See if this bullet hits an enemy.
		BOOL hit = NO;
		NSEnumerator *m;
		m = [enemiesOnField objectEnumerator];
		EnemyUnit *enemyUnitOnField;
		while (enemyUnitOnField = [m nextObject])
		{
			if (enemyUnitOnField.lane != bullet.lane || enemyUnitOnField.health <= 0)
				continue;
			
			CGRect enemyRect = enemyUnitOnField.currentImageView.frame;
			CGRect bulletRect = bullet.bulletView.frame;
			if (CGRectContainsRect(enemyRect, bulletRect))
			{
				// Remove bullet's view from the screen.
				[bullet.bulletView removeFromSuperview];
				[bulletRemoveIndexes addIndex:index];
				
				hit = YES;
				
				// See if enemy dodged it, when enemy is not in condition of locked.
				if ([enemyUnitOnField getCondition:1] == NO)
				{
					int dodgeInt = 100 * enemyUnitOnField.dodgeRate;
					
					int a = arc4random() % 100;
					if (a < dodgeInt)
					{
						// Dodged! Don't reduce health point and show the miss image view.
						
						CGPoint ori;
						ori.x = enemyUnitOnField.currentImageView.frame.origin.x + 6;
						ori.y = enemyUnitOnField.currentImageView.frame.origin.y + 5;
						AttackMissView *missView = [[AttackMissView alloc] initWithLocation:ori];
						[self.view addSubview:missView.currentImageView];
						[missingArray addObject:missView];
						[missView release];
						
						break;
					}
				}
				
				// See if speical effect activates.
				if (bullet.condition != 0)
				{
					int specialCondInt = 100 * bullet.criticalRate;
					
					if ((arc4random() % 100) < specialCondInt)
					{
						// Activate special effect!
						[enemyUnitOnField setCondition:bullet.condition withBoolean:YES];
					}
				}
				
				// Reduce enemy's health point.
				double att = [GameUtils attackPointAfterTypeFixing:bullet.type :enemyUnitOnField.element :bullet.attackPoint];
				
				// Check if enemy is in condition of flawed.
				if ([enemyUnitOnField getCondition:4])
				{
					att *= 1.5;
				}
				
				[enemyUnitOnField reductHealthBy:att];
								
				break;
			}
		}
		
		if (hit) 
		{
			index ++;
			
			continue;
		}
		
		// At this point, this bullet did not hit any enemy, just move it forward.
		[bullet.bulletView removeFromSuperview];
		
		CGRect newFrame = bullet.bulletView.frame;
		newFrame.origin.y -= BULLET_SPEED;
		bullet.bulletView.frame = newFrame;
		
		[self.view addSubview:bullet.bulletView];
		
		index ++;
	}
	[bulletArray removeObjectsAtIndexes:bulletRemoveIndexes];
	
#pragma mark Move All Player's Units

	// Animation when attacking from player's units.
	for (int col = 0; col < 6; col ++)
	{
		for (int row = 0; row < 8; row ++)
		{
			Skill *tempSkill = battleFieldUnits[row][col];
			
			if (tempSkill == nil)		// No unit on this square.
			{
				continue;
			}
			
			if (tempSkill.isDying)
			{
				// Display the dying effect.
				if ([tempSkill changeDyingImage])
				{
					[tempSkill.currentImageView removeFromSuperview];
					[tempSkill.healthOutletView removeFromSuperview];
					[tempSkill.healthImageView removeFromSuperview];
					[tempSkill.dyingImageView removeFromSuperview];
					
					[tempSkill release];
					battleFieldUnits[row][col] = nil;
				}
				
				continue;
			}
			
			// Check the health.
			if (tempSkill.health <= 0)
			{
				// Check if this is a moon soldier.
				if (tempSkill.skillNumber == 11)
				{
					moonPowerModifier -= 0.1;
				}
				
				// Set it to be dying.
				tempSkill.isDying = YES;
				tempSkill.dyingImageView.frame = tempSkill.currentImageView.frame;
				[self.view addSubview:tempSkill.dyingImageView];
				
				continue;
			}
			
			[tempSkill.currentImageView removeFromSuperview];
			[tempSkill.healthOutletView removeFromSuperview];
			[tempSkill.healthImageView removeFromSuperview];
			
			// Check if this unit should be attacking.
			if ([tempSkill ableToAttack] && enemiesInLane[col])
			{
				int attack = tempSkill.attack;
				
				// Check if this is a moon soldier.
				if (tempSkill.skillNumber == 11)
				{
					attack = (int)(attack * moonPowerModifier);
				}
				
				Bullet *bullet = [[Bullet alloc] initWithBulletImage:tempSkill.bulletImage :attack :col 
																	:tempSkill.element :tempSkill.specialEffect 
																	:tempSkill.criticalRate];
				
				// Set the initial coordinate of the bullet view.
				CGRect newFrame = bullet.bulletView.frame;
				newFrame.origin = tempSkill.currentImageView.frame.origin;
				bullet.bulletView.frame = newFrame;
				
				// Add bullet's view to the screen.
				[self.view addSubview:bullet.bulletView];
				
				// Add this bullet to the array.
				[bulletArray addObject:bullet];
				[bullet release];
				
				// Set the unit to be attacking.
				[tempSkill setIsAttacking:YES];
			}
			
			if ([tempSkill isAttacking])
			{
				// Attacking animation.
				[tempSkill switchAttackImage];
			}
			
			[self.view addSubview:tempSkill.healthOutletView];
			[self.view addSubview:tempSkill.healthImageView];
			[self.view addSubview:tempSkill.currentImageView];
		}
	}
	
#pragma mark Upper Magic

	// Iterate through all the upper magic in effect.
	NSMutableIndexSet *upperMagicRemoveIndexes = [NSMutableIndexSet indexSet];
	NSEnumerator *upperMagicEnumerator = [upperMagicArray objectEnumerator];
	index = 0;
	while (curMagic = [upperMagicEnumerator nextObject])
	{
		if ([curMagic isKindOfClass:[MagicTreatment class]])
		{
			MagicTreatment *magicTreatment = (MagicTreatment *)curMagic;
			
			if ([magicTreatment displayNextAnimation]) 
			{		
				[upperMagicRemoveIndexes addIndex:index];
			}
			else 
			{
				// Move it above the unit.
				[magicTreatment.currentImageView removeFromSuperview];
				[self.view addSubview:magicTreatment.currentImageView];
			}
		}
		else if ([curMagic isKindOfClass:[MagicThorn class]])
		{
			MagicThorn *magicThorn = (MagicThorn *)curMagic;
			
			if ([magicThorn displayNextAnimation]) 
			{
				// Unit no longer is protected.
				[magicThorn getUnit].isProtected = NO;
				
				[upperMagicRemoveIndexes addIndex:index];
			}
			else 
			{
				// Move it above the unit.
				[magicThorn.frontImageView removeFromSuperview];
				[[magicThorn getUnit].currentImageView removeFromSuperview];
				[magicThorn.backImageView removeFromSuperview];
				
				[self.view addSubview:magicThorn.backImageView];
				[self.view addSubview:[magicThorn getUnit].currentImageView];
				[self.view addSubview:magicThorn.frontImageView];
			}
		}
		else if ([curMagic isKindOfClass:[MagicHolyLight class]])
		{
			MagicHolyLight *magicHolyLight = (MagicHolyLight *)curMagic;
			
			if ([magicHolyLight getAffectingUnit].isDying)
			{
				[upperMagicRemoveIndexes addIndex:index];
			}
			else if ([magicHolyLight displayNextAnimation])
			{				
				[upperMagicRemoveIndexes addIndex:index];
				
				// Decrease the attack point of the unit.
				[magicHolyLight getAffectingUnit].attack /= 2;
			}
			else
			{
				// Move it above the unit.
				[magicHolyLight.currentImageView removeFromSuperview];
				[self.view addSubview:magicHolyLight.currentImageView];
			}
		}
		
		index ++;
	}
	[upperMagicArray removeObjectsAtIndexes:upperMagicRemoveIndexes];
	
	// All the enemy (field) indexes that suppose to be removed should be in 'enemyOnFieldIndexesToRemove'.
	[enemiesOnField removeObjectsAtIndexes:enemyOnFieldIndexesToRemove];
	
#pragma mark Animate All The Miss View
	
	NSEnumerator *missEnumerator = [missingArray objectEnumerator];
	AttackMissView *currentMissView;
	NSMutableIndexSet *missViewsRemoveIndexes = [NSMutableIndexSet indexSet];
	index = 0;
	while (currentMissView = [missEnumerator nextObject])
	{
		[currentMissView.currentImageView removeFromSuperview];
		
		if ([currentMissView switchToNextImage])
		{			
			[missViewsRemoveIndexes addIndex:index];
		}
		else
		{
			[self.view addSubview:currentMissView.currentImageView];
		}
		
		index ++;
	}
	[missingArray removeObjectsAtIndexes:missViewsRemoveIndexes];
}

// Return the pointer of the unit this enemy should be attacking.
// If it should not be attacking, just return nil.
- (Skill *)getTheUnitInFrontOfThisEnemy:(EnemyUnit *)enemy
{
	CGPoint enemyButtonPoint = enemy.currentImageView.frame.origin;
	enemyButtonPoint.x += 30;
	enemyButtonPoint.y += 55;
	
	// Get the current square this enemy is at.
	for (int i = 0; i < 8; ++i)
	{
		if (CGRectContainsPoint(grids[i][enemy.lane], enemyButtonPoint))
		{
			if (battleFieldUnits[i][enemy.lane] != nil) 
				return battleFieldUnits[i][enemy.lane];
			else 
				return nil;
		}
	}
	
	return nil;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Set button images.
	
	UIImage *gameMenuNormal = [UIImage imageNamed:@"ES_GameEnv_Button_Menu.png"];
	[gameMenuButton setBackgroundImage:gameMenuNormal forState:UIControlStateNormal];
	
	UIImage *gameMenuPressed = [UIImage imageNamed:@"ES_GameEnv_Button_MenuPress.png"];
	[gameMenuButton setBackgroundImage:gameMenuPressed forState:UIControlStateHighlighted];
	
	UIApplication *app = [UIApplication sharedApplication];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(applicationWillTerminate:) 
												 name:UIApplicationWillTerminateNotification 
											   object:app];
	
	[self initializeGame];	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (baseImage.image == nil)
	{
		switch ([GameUtils getCurrentGameStage]) 
		{
			case 0:
			case 1:
			case 2:
			case 3:
			case 4:
				baseImage.image = [UIImage imageNamed:@"ES_GameEnv_BaseLayer_Earth.png"];
				break;
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
				baseImage.image = [UIImage imageNamed:@"ES_GameEnv_BaseLayer_Air.png"];
				break;
			case 10:
			case 11:
			case 12:
			case 13:
			case 14:
				baseImage.image = [UIImage imageNamed:@"ES_GameEnv_BaseLayer_Water.png"];
				break;
			case 15:
			case 16:
			case 17:
			case 18:
			case 19:
				baseImage.image = [UIImage imageNamed:@"ES_GameEnv_BaseLayer_Fire.png"];
				break;
			default:
				baseImage.image = [UIImage imageNamed:@"ES_GameEnv_BaseLayer_Arena.png"];
		}
	}
	
	// This is the only condition which game should be resumed from within this method.
	if ([GameUtils getJustQuittedFromGameMenu])
	{
		[GameUtils setJustQuittedFromGameMenu:NO];
		
		if ([GameUtils getShouldRestartGame])
		{
			[GameUtils setShouldRestartGame:NO];
			
			[self gameEnded];
			[self initializeGame];
		}
		else if ([GameUtils getShouldQuitGame])
		{
			[GameUtils setShouldQuitGame:NO];
			
			[self gameEnded];
			
			// Change BGM to the main theme.
			AVPlaybackSoundController *BGMController = [self theBGMObject];
			[BGMController switchBackgroundMusic:0];
			
			// Make sure this view is on top.
			[self performSelector: @selector(switchViewToMap) withObject: nil afterDelay: 0.1f];			
		}
		else 
		{
			[self resumeGame];
		}
	}
}

// View should be switched to map if player quits the game.
- (void)switchViewToMap
{
	[self.parentViewController.parentViewController dismissModalViewControllerAnimated:YES];
}

// Switch the view to see the game menu.
- (IBAction)switchViewToGameMenu:(id)sender
{
	// Stop the game.
	[self pauseGame];
	
	if(gameMenuViewController == nil)
	{
		Elemental_SymphonyGameMenuViewController *menuController = [[Elemental_SymphonyGameMenuViewController alloc] initWithNibName:@"Elemental_SymphonyGameMenuViewController" bundle:nil];
		self.gameMenuViewController = menuController;
		[menuController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:gameMenuViewController animated:YES];
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
	
	self.baseImage = nil;
	self.gameMenuButton = nil;
	self.gameMenuViewController = nil;
	self.gameOverViewController = nil;
	self.prizeViewController = nil;
	self.arenaScoreViewController = nil;
	self.healthImage = nil;
	self.healthLabel = nil;
	self.magicImage = nil;
	self.magicLabel = nil;
	self.moneyLabel = nil;
	self.numberOfEnemiesLabel = nil;
	
	self.firstAmount = nil;
	self.secondAmount = nil;
	self.thirdAmount = nil;
	self.fourthAmount = nil;
	self.fifthAmount = nil;
	self.sixthAmount = nil;
	self.specialFieldLabel = nil;
}

- (void)dealloc
{
	[baseImage release];
	[gameMenuButton release];
	[gameMenuViewController release];
	[gameOverViewController release];
	[prizeViewController release];
	[arenaScoreViewController release];
	[healthImage release];
	[healthLabel release];
	[magicImage release];
	[magicLabel release];
	[moneyLabel release];
	[numberOfEnemiesLabel release];
	[firstAmount release];
	[secondAmount release];
	[thirdAmount release];
	[fourthAmount release];
	[fifthAmount release];
	[sixthAmount release];
	[specialFieldLabel release];
	
    [super dealloc];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	// Clean the memory allocation.
	if (isPlaying)
	{
		[self gameEnded];
	}	
}

@end
