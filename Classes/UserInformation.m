//
//  UserInformation.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "UserInformation.h"
#import "GameUtils.h"

static UserInformation *sharedInformation = nil;

@implementation UserInformation

@synthesize isSoundOn;
@synthesize name;
@synthesize numberKilled;
@synthesize numberDeath;
@synthesize time;
@synthesize arenaScore;
@synthesize maxMagic;
@synthesize money;
@synthesize volume;
@synthesize numLevelUpStone;

// Whether the stage is passed or not.
- (BOOL)passedStages:(int)stageNumber
{
	return passedStages[stageNumber];
}

// Set the stage to be passed or not passed.
- (void)setPassedStages:(int)stageNumber withBoolean:(BOOL)boolean
{
	passedStages[stageNumber] = boolean;
}

// Get the using skill according to the index.
- (int)usingSkills:(int)index
{
	return usingSkills[index];
}

// Set a one of six skills this player is currently using.
- (void)setUsingSkills:(int)index withSkill:(int)skillNumber
{
	usingSkills[index] = skillNumber;
}

// Return the information about a particular skill.
- (int)skills:(int)index
{
	return skills[index];
}

// Set the skill with a information indicated by the number.
- (void)setSkills:(int)index withNumber:(int)number
{
	skills[index] = number;
}

// Release what's in there and set it to nil.
+ (void)reset
{
	[sharedInformation release];
	sharedInformation = nil;
}

// Return the singleton object of UserInformation.
+ (UserInformation *)sharedManager
{	
	if (sharedInformation == nil)
	{
		sharedInformation = [[super allocWithZone:NULL] init];
		
		sharedInformation.isSoundOn = YES;
		
		// Initialized the object if data exists, if not, use defaults.
		
		if([GameUtils dataExists])
		{
			NSString *filePath = [GameUtils dataFilePath];

			NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
			
			// Set member variables according to the dictionary.
			sharedInformation.name = [dictionary objectForKey:@"name"];
			sharedInformation.numberKilled = [[dictionary objectForKey:@"killed"] unsignedIntValue];
			sharedInformation.numberDeath = [[dictionary objectForKey:@"death"] unsignedIntValue];
			sharedInformation.time = [[dictionary objectForKey:@"time"] unsignedLongValue];
			NSArray *stagesArray = [dictionary objectForKey:@"stages"];
			NSEnumerator *stageEnumerator = [stagesArray objectEnumerator];
			int i = 0;
			NSNumber *objNumber1;
			while (objNumber1 = [stageEnumerator nextObject])
			{
				BOOL passed = [objNumber1 boolValue];

				[sharedInformation setPassedStages:i withBoolean:passed];
				i ++;
			}
			sharedInformation.arenaScore = [[dictionary objectForKey:@"arena"] unsignedIntValue];
			sharedInformation.maxMagic = [[dictionary objectForKey:@"magic"] intValue];
			sharedInformation.money = [[dictionary objectForKey:@"money"] unsignedIntValue];
			sharedInformation.volume = [[dictionary objectForKey:@"sound"] floatValue];
			sharedInformation.numLevelUpStone = [[dictionary objectForKey:@"stone"] intValue];
			NSArray *usingSkillsArray = [dictionary objectForKey:@"usingSkills"];
			NSEnumerator *usingSkillEnumerator = [usingSkillsArray objectEnumerator];
			i = 0;
			NSNumber *objNumber2;
			while (objNumber2 = [usingSkillEnumerator nextObject]) 
			{
				int skillNum = [objNumber2 intValue];

				[sharedInformation setUsingSkills:i withSkill:skillNum];
				i ++;
			}
			NSArray *allSkillsArray = [dictionary objectForKey:@"allSkills"];
			NSEnumerator *allSkillEnumerator = [allSkillsArray objectEnumerator];
			i = 0;
			NSNumber *objNumber3;
			while (objNumber3 = [allSkillEnumerator nextObject])
			{
				int number = [objNumber3 intValue];

				[sharedInformation setSkills:i withNumber:number];
				i ++;
			}
			
			[dictionary release];
		}
		else 
		{
			sharedInformation.name = [NSString stringWithString:@""];
			sharedInformation.numberKilled = 0;
			sharedInformation.numberDeath = 0;
			sharedInformation.time = 0;
			for (int i = 0; i < 20; i++)
				[sharedInformation setPassedStages:i withBoolean:NO];
			sharedInformation.arenaScore = 0;
			sharedInformation.maxMagic = 200;
			sharedInformation.money = 500;
			sharedInformation.volume = 0.5;
			
			sharedInformation.numLevelUpStone = 0;
			
			[sharedInformation setUsingSkills:0 withSkill:12];	// Set using skills to the default.
			for (int i = 1; i < 6; i++)
				[sharedInformation setUsingSkills:i withSkill:0];
			
			for (int i = 0; i < TOTAL_NUMBER_SKILLS; i++)
				[sharedInformation setSkills:i withNumber:0];	// All skill are locked by default,
			[sharedInformation setSkills:11 withNumber:1];		// except the initial one.
		}
	}
	
	return sharedInformation;
}

+ (id)allocWithZone:(NSZone *)zone
{
	return [[self sharedManager] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain
{
	return self;
}

- (unsigned)retainCount
{
	return NSUIntegerMax;
}

- (void)release
{
	// do nothing
}

- (id)autorelease
{
	return self;
}

//	this should never be called.
- (void)dealloc
{	
	[name release];
	
    [super dealloc];
}

@end
