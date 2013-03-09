//
//  UserInformation.h
//  Elemental_Symphony
//	This object contains all the user's information and will be the only object that gets stored.
//	This is a singleton object.
//	
//  Created by Tianyi Wang on 5/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameUtils.h"

@interface UserInformation : NSObject 
{
	BOOL isSoundOn;
	
@private
	NSString *name;
	unsigned int numberKilled;	// How many enemies player killed.
	unsigned int numberDeath;	// How many times player is dead.
	unsigned long time;			// Indicates how long the game has been played.
	
	BOOL passedStages[20];		// Indicates whether the player passed each of 20 stages or not.
	
	unsigned int arenaScore;	// Highest score earned in the arena.
	
	int maxMagic;				// Player's current maximum magic power;
	unsigned int money;			// Player's amount of money.
	float volume;				// Player's sound setting.
	
	int numLevelUpStone;		// The number of level up stones this player has.
	int usingSkills[6];			// The 6 skills player is equiped now, index started w/ 0, 0 means no skill.
	int skills[TOTAL_NUMBER_SKILLS];	// About the skills: 0: don't have it, 1: level 0, 2: level 1, 3: level 2, 4: level 3.
}

@property BOOL isSoundOn;
@property (retain) NSString *name;
@property unsigned int numberKilled;
@property unsigned int numberDeath;
@property unsigned long time;
@property unsigned int arenaScore;
@property int maxMagic;
@property unsigned int money;
@property float volume;
@property int numLevelUpStone;

+ (UserInformation *)sharedManager;
+ (void)reset;

- (BOOL)passedStages:(int)stageNumber;
- (void)setPassedStages:(int)stageNumber withBoolean:(BOOL)boolean;

- (int)usingSkills:(int)index;
- (void)setUsingSkills:(int)index withSkill:(int)skillNumber;

- (int)skills:(int)index;
- (void)setSkills:(int)index withNumber:(int)number;

@end
