//
//  Skill.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Skill.h"
#import "MagicBaseClass.h"
#import "GameUtils.h"
#import "UserInformation.h"

@implementation Skill

@synthesize availablityView;
@synthesize healthOutletView;
@synthesize healthImageView;
@synthesize currentImageView;
@synthesize skillImage;
@synthesize baseImage;
@synthesize setImage;
@synthesize moveImage;
@synthesize bulletImage;
@synthesize dyingImageView;
@synthesize smallImage;

@synthesize skillNumber;
@synthesize isAvailable;
@synthesize amount;
@synthesize element;
@synthesize attack;
@synthesize totalHealth;
@synthesize health;
@synthesize dodgeRate;
@synthesize criticalRate;
@synthesize specialEffect;
@synthesize attackFrequency;
@synthesize isDying;
@synthesize isProtected;

// Initialize this skill with the unique skill number.
- (Skill *)initWithSkillNumber:(int)number
{
	healthOutletView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ES_Units_HPbar_outline.png"]];
	healthImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ES_Units_HPbar.png"]];
	
	skillNumber = number;
	attackCounter = 1;
	isAttacking = NO;
	isAvailable = YES;
	availableCounter = 0;
	
	isProtected = NO;
	
	NSString *skillName = nil;
	NSString *setName = nil;
	NSString *baseName = nil;
	NSString *moveName = nil;
	NSString *bulletName = nil;
	
	UIImage *imageIconG = [UIImage imageNamed:@"ES_GameEnv_Icon_G.png"];
	UIImage *imageIconM = [UIImage imageNamed:@"ES_GameEnv_Icon_M.png"];
	
#define MAGIC_PRODUCE_TIME 10	// 10 seconds.
	
	self.criticalRate = 0.10;	// All units' critical rate starts with 10%.
	
	switch (number)
	{
		case 0:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_None.png"];
			break;
		case 1:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Accurate.png"];
			smallImage = [[UIImageView alloc] initWithImage:imageIconM];
			amount = MAGIC_TARGET;		// Magic.
			produceFrequency = MAGIC_PRODUCE_TIME;
			break;
		case 2:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Corrosion.png"];
			smallImage = [[UIImageView alloc] initWithImage:imageIconM];
			amount = MAGIC_VIRUS;		// Magic.
			produceFrequency = MAGIC_PRODUCE_TIME;
			break;
		case 3:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Dizziness.png"];
			baseName = [NSString stringWithString:@"ES_Units_Warrior_Base.png"];
			moveName = [NSString stringWithString:@"ES_Units_Warrior_Move.png"];
			setName = [NSString stringWithString:@"ES_Units_Warrior_Set.png"];
			bulletName = [NSString stringWithString:@"ES_Units_Warrior_Bullet.png"];
			amount = 175;
			element = 4;
			attack = 35;
			health = 200;
			dodgeRate = 0.01;
			specialEffect = 2;		// Dizzy.
			attackFrequency = 5;
			produceFrequency = 8;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		case 4:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Firegun.png"];
			baseName = [NSString stringWithString:@"ES_Units_Firegun_Base.png"];
			moveName = [NSString stringWithString:@"ES_Units_Firegun_Move.png"];
			setName = [NSString stringWithString:@"ES_Units_Firegun_Set.png"];
			bulletName = [NSString stringWithString:@"ES_Units_Firegun_Bullet.png"];
			amount = 75;
			element = 4;
			attack = 25;
			health = 150;
			dodgeRate = 0.03;
			specialEffect = 3;		// Fire.
			attackFrequency = 3;
			produceFrequency = 6;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		case 5:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Flaw.png"];
			baseName = [NSString stringWithString:@"ES_Units_Fracture_Base.png"];
			moveName = [NSString stringWithString:@"ES_Units_Fracture_Move.png"];
			setName = [NSString stringWithString:@"ES_Units_Fracture_Set.png"];
			bulletName = [NSString stringWithString:@"ES_Units_Fracture_Bullet.png"];
			amount = 125;
			element = 3;
			attack = 30;
			health = 125;
			dodgeRate = 0.03;
			specialEffect = 4;		// Flawed.
			attackFrequency = 3;
			produceFrequency = 6;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		case 6:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Freezing.png"];
			baseName = [NSString stringWithString:@"ES_Units_Frost_Base.png"];
			moveName = [NSString stringWithString:@"ES_Units_Frost_Move.png"];
			setName = [NSString stringWithString:@"ES_Units_Frost_Set.png"];
			bulletName = [NSString stringWithString:@"ES_Units_Frost_Bullet.png"];
			amount = 130;
			element = 3;
			attack = 30;
			health = 120;
			dodgeRate = 0.02;
			specialEffect = 5;		// Freeze.
			attackFrequency = 4;
			produceFrequency = 5;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		case 7:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Gold.png"];
			smallImage = [[UIImageView alloc] initWithImage:imageIconM];
			amount = MAGIC_GOLD_COST;		// Magic.
			produceFrequency = MAGIC_PRODUCE_TIME;
			break;
		case 8:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Lava.png"];
			smallImage = [[UIImageView alloc] initWithImage:imageIconM];
			amount = MAGIC_ERUPTION_COST;	// Magic.
			produceFrequency = MAGIC_PRODUCE_TIME;
			break;
		case 9:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Lighting.png"];
			smallImage = [[UIImageView alloc] initWithImage:imageIconM];
			amount = MAGIC_HOLY_LIGHT;		// Magic.
			produceFrequency = MAGIC_PRODUCE_TIME;
			break;
		case 10:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Poison.png"];
			baseName = [NSString stringWithString:@"ES_Units_Poison_Base.png"];
			moveName = [NSString stringWithString:@"ES_Units_Poison_Move.png"];
			setName = [NSString stringWithString:@"ES_Units_Poison_Set.png"];
			bulletName = [NSString stringWithString:@"ES_Units_Poison_Bullet.png"];
			amount = 150;
			element = 2;
			attack = 25;
			health = 150;
			dodgeRate = 0.01;
			specialEffect = 6;		// Poison.
			attackFrequency = 3;
			produceFrequency = 5;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		case 11:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Shadow.png"];
			baseName = [NSString stringWithString:@"ES_Units_Shadow_Base.png"];
			moveName = [NSString stringWithString:@"ES_Units_Shadow_Move.png"];
			setName = [NSString stringWithString:@"ES_Units_Shadow_Set.png"];
			bulletName = [NSString stringWithString:@"ES_Units_Shadow_Bullet.png"];
			amount = 250;
			element = 0;
			attack = 50;
			health = 150;
			dodgeRate = 0.01;
			specialEffect = 0;		// No special effect.
			attackFrequency = 3;
			produceFrequency = 8;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		case 12:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Slingshot.png"];
			baseName = [NSString stringWithString:@"ES_Units_Slingshot_Base.png"];
			moveName = [NSString stringWithString:@"ES_Units_Slingshot_Move.png"];
			setName = [NSString stringWithString:@"ES_Units_Slingshot_Set.png"];
			bulletName = [NSString stringWithString:@"ES_Units_Slingshot_Bullet.png"];
			amount = 45;
			element = 1;
			attack = 15;
			health = 100;
			dodgeRate = 0.01;
			specialEffect = 0;		// No special effect.
			attackFrequency = 2;
			produceFrequency = 2;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		case 13:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Snowlotus.png"];
			smallImage = [[UIImageView alloc] initWithImage:imageIconM];
			amount = MAGIC_SNOW_LOTUS;		// Magic.
			produceFrequency = MAGIC_PRODUCE_TIME;
			break;
		case 14:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Thorn.png"];
			smallImage = [[UIImageView alloc] initWithImage:imageIconM];
			amount = MAGIC_THORN;			// Magic.
			produceFrequency = MAGIC_PRODUCE_TIME;
			break;
		case 15:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Treatment.png"];
			smallImage = [[UIImageView alloc] initWithImage:imageIconM];
			UserInformation *UInfo = [UserInformation sharedManager];
			int level = [UInfo skills:14];
			unsigned int magicCost;
			if (level == 1)
				magicCost = 120;
			else if (level == 2)
				magicCost = 100;
			else if (level == 3)
				magicCost = 70;
			else 
				magicCost = 30;
			amount = magicCost;		// Magic.
			produceFrequency = MAGIC_PRODUCE_TIME;
			break;
		case 16:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Wall.png"];
			baseName = [NSString stringWithString:@"ES_Units_Fence_Base.png"];
			moveName = nil;
			setName = [NSString stringWithString:@"ES_Units_Fence_Set.png"];
			bulletName = nil;
			amount = 150;
			element = 0;
			attack = 0;
			health = 1000;
			dodgeRate = 0.0;
			specialEffect = 0;		// No special effect.
			attackFrequency = 0;
			produceFrequency = 6;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		case 17:
			skillName = [NSString stringWithString:@"ES_GameEnv_SkillIcon_Weak.png"];
			baseName = [NSString stringWithString:@"ES_Units_Weak_Base.png"];
			moveName = [NSString stringWithString:@"ES_Units_Weak_Move.png"];
			setName = [NSString stringWithString:@"ES_Units_Weak_Set.png"];
			bulletName = [NSString stringWithString:@"ES_Units_Weak_Bullet.png"];
			amount = 100;
			element = 2;
			attack = 20;
			health = 200;
			dodgeRate = 0.05;
			specialEffect = 7;		// Weaken.
			attackFrequency = 2;
			produceFrequency = 4;
			smallImage = [[UIImageView alloc] initWithImage:imageIconG];
			break;
		default:
			break;
	}
	
	// Upgrade depends on the level.
	if ([GameUtils isMagicalSkill:number] == NO)
	{
		UserInformation *UInfo = [UserInformation sharedManager];
		int level = [UInfo skills:number - 1];
		
		if (number != 11 && number != 12 && number != 16)	// Not Fence, Foot Soldier, or Moon Soldier.
		{
			if (level >= 2)
			{
				// At least 1 upgrade.
				health += 20;
			}
			if (level >= 3)
			{
				// At least 2 upgrades.
				attack += 10;
			}
			if (level >= 4)
			{
				// Full upgrade.
				criticalRate += 0.20;
			}
		}
		else if (number == 11 || number == 12)		// Foot Soldier or Moon Soldier.
		{
			if (level >= 2)
			{
				// At least 1 upgrade.
				health += 20;
			}
			if (level >= 3)
			{
				// At least 2 upgrades.
				attack += 10;
			}
			if (level >= 4)
			{
				// Full upgrade.
				dodgeRate += 0.20;
			}
		}
		else				// Fence.
		{
			if (level >= 2)
			{
				// At least 1 upgrade.
				health += 100;
			}
			if (level >= 3)
			{
				// At least 2 upgrades.
				health += 100;
			}
			if (level >= 4)
			{
				// Full upgrade.
				health += 100;
			}
		}
	}
	
	totalHealth = health;
	
	bulletCounter = attackFrequency * 30;
	
	if (skillName != nil)
	{
		skillImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:skillName]];
	}

	if (baseName != nil)
	{
		self.baseImage = [UIImage imageNamed:baseName];
	}

	if (setName != nil)
	{
		self.setImage = [UIImage imageNamed:setName];
	}
	
	if (moveName != nil)
	{
		self.moveImage = [UIImage imageNamed:moveName];
	}
	
	if (bulletName != nil)
	{
		self.bulletImage = [UIImage imageNamed:bulletName];
	}
	
	availablityView = [[UIView alloc] init];
	availablityView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
	
	currentImageView = [[UIImageView alloc] initWithImage:baseImage];
	
	dyingCounter = 0;
	dyingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ES_Unitseffect_Die01.png"]];
	
	return [super init];
}

// Change the dying image in the view.
// Return YES when this unit can be removed from the field.
- (BOOL)changeDyingImage
{
	dyingCounter ++;
	
	switch (dyingCounter)
	{
		case 6:
			dyingImageView.image = [UIImage imageNamed:@"ES_Unitseffect_Die02.png"];
			return NO;
			break;
		case 12:
			dyingImageView.image = [UIImage imageNamed:@"ES_Unitseffect_Die03.png"];
			return NO;
			break;
		case 18:
			dyingImageView.image = [UIImage imageNamed:@"ES_Unitseffect_Die04.png"];
			return NO;
			break;
		case 24:
			dyingImageView.image = [UIImage imageNamed:@"ES_Unitseffect_Die05.png"];
			return YES;
			break;
		default:
			break;
	}
	
	return NO;
}

// Set whether or not this unit is attacking.
- (void)setIsAttacking:(BOOL)attacking
{
	// Reset the bullet counter to make it unavailable to attack during next few seconds.
	bulletCounter = 0;
	
	isAttacking = attacking;
}

// Return YES if this unit is attacking.
- (BOOL)isAttacking
{
	return isAttacking;
}

// This method will be counting to make itself available.
// It will be called 30 times / second when it's not available.
- (void)tryToMakeAvailable
{
	if (isAvailable) 
		return;
	
	availableCounter ++;

	// Time up! Make it available.
	if (availableCounter == produceFrequency * 30)
	{
		availableCounter = 0;
		
		isAvailable = YES;
		
		[availablityView removeFromSuperview];
		
		availablityView.frame = skillImage.frame;
		
		return;
	}
	
	// Update the white frame after each second.
	if (availableCounter % 30 == 0)
	{
		CGFloat currentHeight = 45.0 * ( 1 - availableCounter / ((CGFloat)produceFrequency * 30) );
		CGRect newFrame = skillImage.frame;
		newFrame.size.height = currentHeight;
		availablityView.frame = newFrame;
	}
}

// Switch the image to show attack move.
- (void)switchAttackImage
{
	if (moveImage == nil)
	{
		return;
	}
	
#define SWITCH_FREQUENCY 8
	// To slow down the attack moving frequency.
	if (attackCounter % SWITCH_FREQUENCY != 0)
	{
		attackCounter ++;
		return;
	}
	
	if (self.currentImageView.image == self.baseImage) 
	{
		[self setCurrentImageViewTo:self.moveImage];
	}
	else
	{
		[self setCurrentImageViewTo:self.baseImage];
	}
	
	if (attackCounter == 4 * SWITCH_FREQUENCY) 
	{
		isAttacking = NO;
		attackCounter = 1;
	}
	else
		attackCounter ++;
}

// Return YES if this skill can attack. Otherwise NO.
// This method will be call 30 times / second.
- (BOOL)ableToAttack
{
	if (bulletImage == nil)
	{
		return NO;
	}
	
	if (bulletCounter / 30 == attackFrequency)
	{
		return YES;
	}
	
	bulletCounter ++;
	return NO;
}

// Reduce the health point by this amount.
- (void)reduceHealthBy:(double)lostHealthPoint
{
	health -= lostHealthPoint;
	
	if (health < 0)
	{
		health = 0;
	}
	
	// Update the health bar.
	// 37 is the pixel length of the HP bar.
	CGRect newFrame = healthImageView.frame;
	double fraction = health / totalHealth;
	newFrame.size.width = 37 * fraction;
	healthImageView.frame = newFrame;
}

// Set image back to base image.
- (void)resetImage
{
	[self setCurrentImageViewTo:self.baseImage];
}

// Change the current image.
- (void)setCurrentImageViewTo:(UIImage *)image
{
	currentImageView.image = image;
}

- (id)mutableCopyWithZone: (NSZone *)zone
{
	return [[Skill alloc] initWithSkillNumber:skillNumber];
}

- (void)dealloc
{
	[availablityView release];
	[healthOutletView release];
	[healthImageView release];
	[currentImageView release];
	[skillImage release];
	[smallImage release];
	[dyingImageView release];
	
	[baseImage release];
	[setImage release];
	[bulletImage release];
	[moveImage release];
	
	[super dealloc];
}

@end
