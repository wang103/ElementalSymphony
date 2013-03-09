//
//  EnemyUnit.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "EnemyUnit.h"
#import "GameUtils.h"

#define ATTACK_A_PLUS	40
#define ATTACK_A		38
#define ATTACK_A_MINUS	36
#define ATTACK_B_PLUS	34
#define ATTACK_B		32
#define ATTACK_B_MINUS	30
#define ATTACK_C_PLUS	28
#define	ATTACK_C		26
#define ATTACK_C_MINUS	24
#define ATTACK_D_PLUS	22
#define ATTACK_D		20
#define ATTACK_D_MINUS	18

#define HEALTH_A_PLUS	160
#define HEALTH_A		155
#define HEALTH_A_MINUS	150
#define HEALTH_B_PLUS	140
#define HEALTH_B		135
#define HEALTH_B_MINUS	130
#define HEALTH_C_PLUS	125
#define	HEALTH_C		120
#define HEALTH_C_MINUS	115
#define HEALTH_D_PLUS	110
#define HEALTH_D		105
#define HEALTH_D_MINUS	100

#define SPEED_A_PLUS	0.90
#define SPEED_A			0.88
#define SPEED_A_MINUS	0.86
#define SPEED_B_PLUS	0.84
#define SPEED_B			0.82
#define SPEED_B_MINUS	0.80
#define SPEED_C_PLUS	0.78
#define	SPEED_C			0.76
#define SPEED_C_MINUS	0.74
#define SPEED_D_PLUS	0.72
#define SPEED_D			0.70
#define SPEED_D_MINUS	0.68

#define ATTACK_FREQUENCY_HIGH	2
#define ATTACK_FREQUENCY_MID	3
#define ATTACK_FREQUENCY_LOW	4

@implementation EnemyUnit

@synthesize healthOutletView;
@synthesize healthImageView;
@synthesize currentImageView;
@synthesize conditionImageView;
@synthesize walkImage1;
@synthesize walkImage2;
@synthesize walkImage3;
@synthesize attackImage1;
@synthesize attackImage2;
@synthesize attackImage3;
@synthesize attackImage4;

@synthesize element;
@synthesize attack;
@synthesize health;
@synthesize speed;
@synthesize dodgeRate;
@synthesize lane;
@synthesize isAttacking;
@synthesize conditionCounter;

/**
 * Special conditions:
 * 0 -- freeze	// By magic
 * 1 -- locked	// By magic
 * 2 -- dizzy	// By unit
 * 3 -- fired	// By unit
 * 4 -- flawed	// By unit
 * 5 -- freeze	// By unit
 * 6 -- poison	// By unit
 * 7 -- weaken	// By unit
 *
 * Only one condition at a time, the rest will be cleared.
 */
- (void)setCondition:(int)index withBoolean:(BOOL)boolean
{	
	if (boolean)
	{
		// Clean other condition caused by unit if this is caused by unit.
		if (index >= 2 && index < 8)
		{
			for (int i = 2; i < 8; i++)
			{
				conditions[i] = NO;
			}
			
			// Start to count for the special condition.
			conditionCounter = 1;
		}
		
		UIImage *image = nil;
		switch (index)
		{
			case 2:
				image = [UIImage imageNamed:@"ES_GameEnv_Small_Dizziness.png"];
				break;
			case 3:
				image = [UIImage imageNamed:@"ES_GameEnv_Small_Firegun.png"];
				break;
			case 4:
				image = [UIImage imageNamed:@"ES_GameEnv_Small_Flaw.png"];
				break;
			case 5:
				image = [UIImage imageNamed:@"ES_GameEnv_Small_Freezing.png"];
				break;
			case 6:
				image = [UIImage imageNamed:@"ES_GameEnv_Small_Poison.png"];
				break;
			case 7:
				image = [UIImage imageNamed:@"ES_GameEnv_Small_Weak.png"];
				break;
			default:
				break;
		}
		
		if (image != nil)
		{
			// Put up the small condition image.
			conditionImageView.image = image;
		}
	}
	else 
	{
		// Condition is set to NO, if this is a condition caused by unit, clear the image.
		if (index != 0 && index != 1) 
		{
			// Remove the image.
			conditionImageView.image = nil;
		}
	}
	
	conditions[index] = boolean;
}

// Clear all conditions caused by units.
- (void)clearUnitConditions
{
	for (int i = 2; i < 8; i ++)
	{
		conditions[i] = NO;
	}
	conditionImageView.image = nil;
	conditionCounter = 0;
}

- (BOOL)getCondition:(int)index
{
	return conditions[index];
}

- (EnemyUnit *)initWithEnemyNumber:(int)number
{	
	// No special conditions.
	for (int i = 0; i < 8; i ++)
	{
		conditions[i] = NO;
	}
	conditionImageView = [[UIImageView alloc] initWithImage:nil];
	conditionCounter = 0;
	
	healthOutletView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ES_Units_HPbar_outline.png"]];
	healthImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ES_Units_HPbar.png"]];
	
	// Initialize them to the defaults.
	walkAnimeCounter = 0;
	isAttacking = NO;
	attackAnimeCounter = 0;
	
	NSString *walkImage1Name;
	NSString *walkImage2Name;
	NSString *walkImage3Name;
	NSString *attackImage1Name;
	NSString *attackImage2Name;
	NSString *attackImage3Name;
	NSString *attackImage4Name;
	
	switch (number)
	{
		case 1:
			walkImage1Name = [NSString stringWithString:@"Air_A_01.png"];
			walkImage2Name = [NSString stringWithString:@"Air_A_02.png"];
			walkImage3Name = [NSString stringWithString:@"Air_A_03.png"];
			attackImage1Name = [NSString stringWithString:@"Air_A_04.png"];
			attackImage2Name = [NSString stringWithString:@"Air_A_05.png"];
			attackImage3Name = [NSString stringWithString:@"Air_A_06.png"];
			attackImage4Name = [NSString stringWithString:@"Air_A_07.png"];
			element = 2;
			attack = ATTACK_B_MINUS;
			health = HEALTH_C;
			speed = SPEED_C_PLUS;
			dodgeRate = 0.02;
			attackFrequency = ATTACK_FREQUENCY_MID;
			break;
		case 2:
			walkImage1Name = [NSString stringWithString:@"Air_B_01.png"];
			walkImage2Name = [NSString stringWithString:@"Air_B_02.png"];
			walkImage3Name = [NSString stringWithString:@"Air_B_03.png"];
			attackImage1Name = [NSString stringWithString:@"Air_B_04.png"];
			attackImage2Name = [NSString stringWithString:@"Air_B_05.png"];
			attackImage3Name = [NSString stringWithString:@"Air_B_06.png"];
			attackImage4Name = [NSString stringWithString:@"Air_B_07.png"];
			element = 2;
			attack = ATTACK_B;
			health = HEALTH_B_PLUS;
			speed = SPEED_B_MINUS;
			dodgeRate = 0.03;
			attackFrequency = ATTACK_FREQUENCY_MID;
			break;
		case 3:
			walkImage1Name = [NSString stringWithString:@"Air_C_01.png"];
			walkImage2Name = [NSString stringWithString:@"Air_C_02.png"];
			walkImage3Name = [NSString stringWithString:@"Air_C_03.png"];
			attackImage1Name = [NSString stringWithString:@"Air_C_04.png"];
			attackImage2Name = [NSString stringWithString:@"Air_C_05.png"];
			attackImage3Name = [NSString stringWithString:@"Air_C_06.png"];
			attackImage4Name = [NSString stringWithString:@"Air_C_07.png"];
			element = 2;
			attack = ATTACK_A;
			health = HEALTH_C_MINUS;
			speed = SPEED_C_PLUS;
			dodgeRate = 0.03;
			attackFrequency = ATTACK_FREQUENCY_LOW;
			break;
		case 4:
			walkImage1Name = [NSString stringWithString:@"Earth_A_01.png"];
			walkImage2Name = [NSString stringWithString:@"Earth_A_02.png"];
			walkImage3Name = [NSString stringWithString:@"Earth_A_03.png"];
			attackImage1Name = [NSString stringWithString:@"Earth_A_04.png"];
			attackImage2Name = [NSString stringWithString:@"Earth_A_05.png"];
			attackImage3Name = [NSString stringWithString:@"Earth_A_06.png"];
			attackImage4Name = [NSString stringWithString:@"Earth_A_07.png"];
			element = 1;
			attack = ATTACK_C;
			health = HEALTH_D;
			speed = SPEED_C;
			dodgeRate = 0.01;
			attackFrequency = ATTACK_FREQUENCY_MID;
			break;
		case 5:
			walkImage1Name = [NSString stringWithString:@"Earth_B_01.png"];
			walkImage2Name = [NSString stringWithString:@"Earth_B_02.png"];
			walkImage3Name = [NSString stringWithString:@"Earth_B_03.png"];
			attackImage1Name = [NSString stringWithString:@"Earth_B_04.png"];
			attackImage2Name = [NSString stringWithString:@"Earth_B_05.png"];
			attackImage3Name = [NSString stringWithString:@"Earth_B_06.png"];
			attackImage4Name = [NSString stringWithString:@"Earth_B_07.png"];
			element = 1;
			attack = ATTACK_B;
			health = HEALTH_D_MINUS;
			speed = SPEED_A_MINUS;
			dodgeRate = 0.05;
			attackFrequency = ATTACK_FREQUENCY_HIGH;
			break;
		case 6:
			walkImage1Name = [NSString stringWithString:@"Earth_C_01.png"];
			walkImage2Name = [NSString stringWithString:@"Earth_C_02.png"];
			walkImage3Name = [NSString stringWithString:@"Earth_C_03.png"];
			attackImage1Name = [NSString stringWithString:@"Earth_C_04.png"];
			attackImage2Name = [NSString stringWithString:@"Earth_C_05.png"];
			attackImage3Name = [NSString stringWithString:@"Earth_C_06.png"];
			attackImage4Name = [NSString stringWithString:@"Earth_C_07.png"];
			element = 1;
			attack = ATTACK_A_MINUS;
			health = HEALTH_B_MINUS;
			speed = SPEED_D;
			dodgeRate = 0.01;
			attackFrequency = ATTACK_FREQUENCY_LOW;
			break;
		case 7:
			walkImage1Name = [NSString stringWithString:@"Fire_A_01.png"];
			walkImage2Name = [NSString stringWithString:@"Fire_A_02.png"];
			walkImage3Name = [NSString stringWithString:@"Fire_A_03.png"];
			attackImage1Name = [NSString stringWithString:@"Fire_A_04.png"];
			attackImage2Name = [NSString stringWithString:@"Fire_A_05.png"];
			attackImage3Name = [NSString stringWithString:@"Fire_A_06.png"];
			attackImage4Name = [NSString stringWithString:@"Fire_A_07.png"];
			element = 4;
			attack = ATTACK_A_MINUS;
			health = HEALTH_A_MINUS;
			speed = SPEED_B;
			dodgeRate = 0.05;
			attackFrequency = ATTACK_FREQUENCY_MID;
			break;
		case 8:
			walkImage1Name = [NSString stringWithString:@"Fire_B_01.png"];
			walkImage2Name = [NSString stringWithString:@"Fire_B_02.png"];
			walkImage3Name = [NSString stringWithString:@"Fire_B_03.png"];
			attackImage1Name = [NSString stringWithString:@"Fire_B_04.png"];
			attackImage2Name = [NSString stringWithString:@"Fire_B_05.png"];
			attackImage3Name = [NSString stringWithString:@"Fire_B_06.png"];
			attackImage4Name = [NSString stringWithString:@"Fire_B_07.png"];
			element = 4;
			attack = ATTACK_A;
			health = HEALTH_A;
			speed = SPEED_B;
			dodgeRate = 0.08;
			attackFrequency = ATTACK_FREQUENCY_MID;
			break;
		case 9:
			walkImage1Name = [NSString stringWithString:@"Fire_C_01.png"];
			walkImage2Name = [NSString stringWithString:@"Fire_C_02.png"];
			walkImage3Name = [NSString stringWithString:@"Fire_C_03.png"];
			attackImage1Name = [NSString stringWithString:@"Fire_C_04.png"];
			attackImage2Name = [NSString stringWithString:@"Fire_C_05.png"];
			attackImage3Name = [NSString stringWithString:@"Fire_C_06.png"];
			attackImage4Name = [NSString stringWithString:@"Fire_C_07.png"];
			element = 4;
			attack = ATTACK_A_PLUS;
			health = HEALTH_A_PLUS;
			speed = SPEED_B_PLUS;
			dodgeRate = 0.10;
			attackFrequency = ATTACK_FREQUENCY_MID;
			break;
		case 10:
			walkImage1Name = [NSString stringWithString:@"Water_A_01.png"];
			walkImage2Name = [NSString stringWithString:@"Water_A_02.png"];
			walkImage3Name = [NSString stringWithString:@"Water_A_03.png"];
			attackImage1Name = [NSString stringWithString:@"Water_A_04.png"];
			attackImage2Name = [NSString stringWithString:@"Water_A_05.png"];
			attackImage3Name = [NSString stringWithString:@"Water_A_06.png"];
			attackImage4Name = [NSString stringWithString:@"Water_A_07.png"];
			element = 3;
			attack = ATTACK_B;
			health = HEALTH_B_PLUS;
			speed = SPEED_B_PLUS;
			dodgeRate = 0.03;
			attackFrequency = ATTACK_FREQUENCY_MID;
			break;
		case 11:
			walkImage1Name = [NSString stringWithString:@"Water_B_01.png"];
			walkImage2Name = [NSString stringWithString:@"Water_B_02.png"];
			walkImage3Name = [NSString stringWithString:@"Water_B_03.png"];
			attackImage1Name = [NSString stringWithString:@"Water_B_04.png"];
			attackImage2Name = [NSString stringWithString:@"Water_B_05.png"];
			attackImage3Name = [NSString stringWithString:@"Water_B_06.png"];
			attackImage4Name = [NSString stringWithString:@"Water_B_07.png"];
			element = 3;
			attack = ATTACK_B_PLUS;
			health = HEALTH_B;
			speed = SPEED_A_MINUS;
			dodgeRate = 0.15;
			attackFrequency = ATTACK_FREQUENCY_MID;
			break;
		case 12:
			walkImage1Name = [NSString stringWithString:@"Water_C_01.png"];
			walkImage2Name = [NSString stringWithString:@"Water_C_02.png"];
			walkImage3Name = [NSString stringWithString:@"Water_C_03.png"];
			attackImage1Name = [NSString stringWithString:@"Water_C_04.png"];
			attackImage2Name = [NSString stringWithString:@"Water_C_05.png"];
			attackImage3Name = [NSString stringWithString:@"Water_C_06.png"];
			attackImage4Name = [NSString stringWithString:@"Water_C_07.png"];
			element = 3;
			attack = ATTACK_A_MINUS;
			health = HEALTH_A;
			speed = SPEED_C_PLUS;
			dodgeRate = 0.35;
			attackFrequency = ATTACK_FREQUENCY_LOW;
			break;
		default:
			break;
	}
	
	totalHealth = health;
	
	ableToAttackCounter = attackFrequency * 30;
	
	self.walkImage1 = [UIImage imageNamed:walkImage1Name];
	self.walkImage2 = [UIImage imageNamed:walkImage2Name];
	self.walkImage3 = [UIImage imageNamed:walkImage3Name];
	self.attackImage1 = [UIImage imageNamed:attackImage1Name];
	self.attackImage2 = [UIImage imageNamed:attackImage2Name];
	self.attackImage3 = [UIImage imageNamed:attackImage3Name];
	self.attackImage4 = [UIImage imageNamed:attackImage4Name];

	currentImageView = [[UIImageView alloc] initWithImage:walkImage1];
	
	return [super init];
}

// Switch to next walking animation.
// This method will be called 30 times a second.
- (void)switchToNextWalkingAnimation
{
	walkAnimeCounter ++;
	
	if (walkAnimeCounter != 6)		// 6 means 0.2 second staying time.
		return;
	
	// Reset it to 0.
	walkAnimeCounter = 0;
	
	if (currentImageView.image == walkImage1)
	{
		currentImageView.image = walkImage2;
	}
	else if (currentImageView.image == walkImage2)
	{
		currentImageView.image = walkImage3;
	}
	else
	{
		currentImageView.image = walkImage1;
	}
}

// This method is for sorting enemy in the array.
- (NSComparisonResult)comparatorForEnemy:(EnemyUnit *)e
{
	if (e.currentImageView.frame.origin.y < self.currentImageView.frame.origin.y)
	{
		return NSOrderedDescending;
	}
	else if (e.currentImageView.frame.origin.y > self.currentImageView.frame.origin.y)
	{
		return NSOrderedAscending;
	}
	return NSOrderedSame;
}

// Reduce the health point by this amount.
- (void)reductHealthBy:(double)lostHealthPoint
{
	health -= lostHealthPoint;
	
	if (health < 0)
	{
		health = 0.0;
	}
	
	// Update the health bar.
	// 37 is the pixel length of the HP bar.
	CGRect newFrame = healthImageView.frame;
	double fraction = health / totalHealth;
	newFrame.size.width = 37 * fraction;
	healthImageView.frame = newFrame;
}

// During the attacking mode, switch to next attack animation.
// This method will be called 30 times a second.
- (void)switchToNextAttackAnimation
{
	attackAnimeCounter ++;
	
	if (attackAnimeCounter % 6 != 0)		// 6 means 0.2 seconds staying time.
		return;
	
	if (currentImageView.image == attackImage1)
	{
		currentImageView.image = attackImage2;
	}
	else if (currentImageView.image == attackImage2)
	{
		currentImageView.image = attackImage3;
	}
	else if (currentImageView.image == attackImage3)
	{
		currentImageView.image = attackImage4;
	}
	else if (currentImageView.image == attackImage4)
	{
		currentImageView.image = walkImage1;
	}
	else
	{
		currentImageView.image = attackImage1;
	}
	
	// One attack phase has 5 steps.
	if (attackAnimeCounter == 36)
	{
		// Attack is done.
		currentImageView.image = walkImage1;
		
		isAttacking = NO;
		attackAnimeCounter = 0;
	}
}

// This method will be call 30 times a second.
// Return whether or not this enemy is able to attack.
- (BOOL)isAbleToAttack
{
	if (ableToAttackCounter == attackFrequency * 30)
	{
		return YES;
	}
	
	ableToAttackCounter ++;
	
	return NO;
}

// When this enemy is able to attack, call this method first before attacking animation.
- (void)switchToAttackMode
{
	isAttacking = YES;
	walkAnimeCounter = 0;
	ableToAttackCounter = 0;
}

- (void)dealloc
{
	[healthOutletView release];
	[healthImageView release];
	[currentImageView release];
	[conditionImageView release];
	[walkImage1 release];
	[walkImage2 release];
	[walkImage3 release];
	[attackImage1 release];
	[attackImage2 release];
	[attackImage3 release];
	[attackImage4 release];
	
	[super dealloc];
}

@end
