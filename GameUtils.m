//
//  GameUtils.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 6/21/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "GameUtils.h"
#import "UserInformation.h"

static int currentGameStage = -1;	// 0 to 20.
static BOOL justQuittedFromGameMenu = NO;
static BOOL gameShouldRestart = NO;
static BOOL gameShouldQuit = NO;
static NSDate *startTime = nil;

@implementation GameUtils

+ (void)startTimeCount
{
	if (startTime == nil)
	{
		startTime = [NSDate date];
		[startTime retain];
	}
}

+ (void)restartTimeCount
{
	[startTime release];
	startTime = [NSDate date];
	[startTime retain];
}

// Game is saved after entering a name, choosing prize, update units, and every time done with arena.
+ (unsigned long)getTimePassed
{
	double d = [startTime timeIntervalSinceNow] * -1;
	return (unsigned long)d;
}

+ (void)saveTheGame
{
	UserInformation *UInfo = [UserInformation sharedManager];
	
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	
	[dictionary setValue:UInfo.name forKey:@"name"];
	[dictionary setValue:[NSNumber numberWithUnsignedInt:UInfo.numberKilled] forKey:@"killed"];
	[dictionary setValue:[NSNumber numberWithUnsignedInt:UInfo.numberDeath] forKey:@"death"];
	UInfo.time += [self getTimePassed];
	[self restartTimeCount];
	[dictionary setValue:[NSNumber numberWithUnsignedLong:UInfo.time] forKey:@"time"];
	NSMutableArray *stagesArray = [[NSMutableArray alloc] init];
	for(int i = 0; i < 20; i++)
	{
		[stagesArray addObject:[NSNumber numberWithBool:[UInfo passedStages:i]]];
	}
	[dictionary setValue:stagesArray forKey:@"stages"];
	[dictionary setValue:[NSNumber numberWithUnsignedInt:UInfo.arenaScore] forKey:@"arena"];
	[dictionary setValue:[NSNumber numberWithInt:UInfo.maxMagic] forKey:@"magic"];
	[dictionary setValue:[NSNumber numberWithUnsignedInt:UInfo.money] forKey:@"money"];
	[dictionary setValue:[NSNumber numberWithFloat:UInfo.volume] forKey:@"sound"];
	[dictionary setValue:[NSNumber numberWithInt:UInfo.numLevelUpStone] forKey:@"stone"];
	NSMutableArray *usingArray = [[NSMutableArray alloc] init];
	for(int i = 0; i < 6; i++)
	{
		[usingArray addObject:[NSNumber numberWithInt:[UInfo usingSkills:i]]];
	}
	[dictionary setValue:usingArray forKey:@"usingSkills"];
	NSMutableArray *allArray = [[NSMutableArray alloc] init];
	for(int i = 0; i < TOTAL_NUMBER_SKILLS; i++)
	{
		[allArray addObject:[NSNumber numberWithInt:[UInfo skills:i]]];
	}
	[dictionary setValue:allArray forKey:@"allSkills"];
	
	[dictionary writeToFile:[GameUtils dataFilePath] atomically:YES];
	[stagesArray release];
	[usingArray release];
	[allArray release];
	[dictionary release];
}

// Return a NSString that represent the data file path.
+ (NSString *)dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

// Return YES if user data exists already. No otherwise.
+ (bool)dataExists
{
	NSString *filePath = [GameUtils dataFilePath];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
		return YES;
	
	return NO;
}

// Delete the data file. Ignore if there is no data file.
+ (void)deleteDataFile
{
	if ([self dataExists])
	{
		NSString *filePath = [GameUtils dataFilePath];
		
		[[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
	}
}

// Return the attacking point after type fixing.
+ (double)attackPointAfterTypeFixing:(int)attackType :(int)defendType :(int)attack
{
	// 0: none
	// 1: earth
	// 2: air
	// 3: water
	// 4: fire
	// Earth > Water > Fire > Air > Earth.
	
	double attackAfterFix = attack;
	
	switch (attackType)
	{
		case 1:
			if (defendType == 3) 
				attackAfterFix *= (1 + TYPE_FIXING);
			else if (defendType == 2)
				attackAfterFix *= (1 - TYPE_FIXING);
			break;
		case 2:
			if (defendType == 1) 
				attackAfterFix *= (1 + TYPE_FIXING);
			else if (defendType == 4)
				attackAfterFix *= (1 - TYPE_FIXING);
			break;
		case 3:
			if (defendType == 4) 
				attackAfterFix *= (1 + TYPE_FIXING);
			else if (defendType == 1)
				attackAfterFix *= (1 - TYPE_FIXING);
			break;
		case 4:
			if (defendType == 2) 
				attackAfterFix *= (1 + TYPE_FIXING);
			else if (defendType == 3)
				attackAfterFix *= (1 - TYPE_FIXING);
			break;
		default:
			break;
	}
	
	return attackAfterFix;
}

// index: 0 ~ 16.
+ (int)getRealIndexFromGameIndex:(int)index
{
	int realIndex;
	
	switch (index)
	{
		case 0:
			realIndex = 11;
			break;
		case 1:
			realIndex = 15;
			break;
		case 2:
			realIndex = 7;
			break;
		case 3:
			realIndex = 16;
			break;
		case 4:
			realIndex = 6;
			break;
		case 5:
			realIndex = 3;
			break;
		case 6:
			realIndex = 13;
			break;
		case 7:
			realIndex = 9;
			break;
		case 8:
			realIndex = 1;
			break;
		case 9:
			realIndex = 5;
			break;
		case 10:
			realIndex = 0;
			break;
		case 11:
			realIndex = 2;
			break;
		case 12:
			realIndex = 8;
			break;
		case 13:
			realIndex = 4;
			break;
		case 14:
			realIndex = 12;
			break;
		case 15:
			realIndex = 10;
			break;
		case 16:
			realIndex = 14;
			break;
		default:
			break;
	}
	
	return realIndex;
}

// Return the correct image name, index is 0 ~ 16.
+ (NSString *)getDescriptionImageNameFromSkillIndex:(int)index
{
	NSString *imageName = nil;
	
	switch (index)
	{
		case 0:
			imageName = [NSString stringWithString:@"ES_StageCleared_FootSolider.png"];
			break;
		case 1:
			imageName = [NSString stringWithString:@"ES_StageCleared_Fence.png"];
			break;
		case 2:
			imageName = [NSString stringWithString:@"ES_StageCleared_VolvanicEruption.png"];
			break;
		case 3:
			imageName = [NSString stringWithString:@"ES_StageCleared_Sorceress.png"];
			break;
		case 4:
			imageName = [NSString stringWithString:@"ES_StageCleared_GoldenTouch.png"];
			break;
		case 5:
			imageName = [NSString stringWithString:@"ES_StageCleared_IncendiaryUnit.png"];
			break;
		case 6:
			imageName = [NSString stringWithString:@"ES_StageCleared_GuardianAngel.png"];
			break;
		case 7:
			imageName = [NSString stringWithString:@"ES_StageCleared_BiochemicalEngineer.png"];
			break;
		case 8:
			imageName = [NSString stringWithString:@"ES_StageCleared_UVFlowerPowder.png"];
			break;
		case 9:
			imageName = [NSString stringWithString:@"ES_StageCleared_Iceman.png"];
			break;
		case 10:
			imageName = [NSString stringWithString:@"ES_StageCleared_TargetLock.png"];
			break;
		case 11:
			imageName = [NSString stringWithString:@"ES_StageCleared_Gladiator.png"];
			break;
		case 12:
			imageName = [NSString stringWithString:@"ES_StageCleared_HolyLight.png"];
			break;
		case 13:
			imageName = [NSString stringWithString:@"ES_StageCleared_Archer.png"];
			break;
		case 14:
			imageName = [NSString stringWithString:@"ES_StageCleared_SnowLotus.png"];
			break;
		case 15:
			imageName = [NSString stringWithString:@"ES_StageCleared_MoonSoldier.png"];
			break;
		case 16:
			imageName = [NSString stringWithString:@"ES_StageCleared_Health.png"];
			break;
		default:
			break;
	}
	
	return imageName;
}

// Return YES if two CGRect's are the same. Otherwise NO.
+ (BOOL)compareCGRect:(CGRect)rect1 isSameAs:(CGRect)rect2
{
	if (rect1.origin.x == rect2.origin.x && rect1.origin.y == rect2.origin.y
		&& rect1.size.height == rect2.size.height && rect1.size.width == rect2.size.width)
		return YES;
	
	return NO;
}

// Return YES if point is inside the rect. Otherwise NO.
+ (BOOL)CGPointInsideCGRect:(CGPoint)point :(CGRect)rect
{
	if (point.x >= rect.origin.x && point.x <= rect.origin.x + rect.size.width
		&& point.y >= rect.origin.y && point.y <= rect.origin.y + rect.size.height)
		return YES;
	
	return NO;
}

// Set the current game stage.
+ (void)setCurrentGameStage:(int)stage
{
	currentGameStage = stage;
}

// Get the current game stage.
+ (int)getCurrentGameStage
{
	return currentGameStage;
}

// Set the boolean.
+ (void)setJustQuittedFromGameMenu:(BOOL)b
{
	justQuittedFromGameMenu = b;
}

// Get the boolean.
+ (BOOL)getJustQuittedFromGameMenu
{
	return justQuittedFromGameMenu;
}

+ (void)setShouldRestartGame:(BOOL)b
{
	gameShouldRestart = b;
}

+ (BOOL)getShouldRestartGame
{
	return gameShouldRestart;
}

+ (void)setShouldQuitGame:(BOOL)b
{
	gameShouldQuit = b;
}

+ (BOOL)getShouldQuitGame
{
	return gameShouldQuit;
}

// This function returns YES if the skill number represents a magical skill,
// otherwise it returns NO.
+ (BOOL)isMagicalSkill:(int)skillNumber
{
	if (skillNumber == 3 || skillNumber == 4 || skillNumber == 5 || skillNumber == 6 ||
		skillNumber == 10 || skillNumber == 11 || skillNumber == 12 || skillNumber == 16 ||
		skillNumber == 17)
		return NO;
	
	return YES;
}

@end
