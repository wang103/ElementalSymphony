//
//  GameUtils.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 6/21/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AWARD_GOLD_PER_ENEMY 5			// Gold get for each kill.
#define AWARD_MAGIC_PER_ENEMY 5			// Magic get for each kill.

#define ARENA_MONEY 2000				// The money player gets for arena.

#define MAX_HEALTH 100					// The maximum health for player always stay 100.
#define MAX_MONEY 9999					// Maximum amount of money player can have.

#define SPECIAL_EFFECT_LENGTH 300		// The interval of special effect lasing, 300 indicates 10 seconds.

#define TYPE_FIXING 0.20				// Earth > Water > Fire > Air > Earth.
#define GROUND_FIXING 0.20				// For when a unit is placed at a special ground.

#define BULLET_SPEED 7					// The speed of bullet shoot by player's army.

#define TOTAL_NUMBER_SKILLS 17			// The total number of skills player can possibly has.

#define kFileName @"data.plist"

@interface GameUtils : NSObject 
{
}

+ (void)saveTheGame;
+ (NSString *)dataFilePath;
+ (bool)dataExists;
+ (void)deleteDataFile;
+ (BOOL)compareCGRect:(CGRect)rect1 isSameAs:(CGRect)rect2;
+ (BOOL)CGPointInsideCGRect:(CGPoint)point :(CGRect)rect;
+ (void)setCurrentGameStage:(int)stage;
+ (int)getCurrentGameStage;
+ (void)startTimeCount;
+ (void)restartTimeCount;
+ (unsigned long)getTimePassed;
+ (void)setJustQuittedFromGameMenu:(BOOL)b;
+ (BOOL)getJustQuittedFromGameMenu;
+ (void)setShouldRestartGame:(BOOL)b;
+ (BOOL)getShouldRestartGame;
+ (void)setShouldQuitGame:(BOOL)b;
+ (BOOL)getShouldQuitGame;
+ (double)attackPointAfterTypeFixing:(int)attackType :(int)defendType :(int)attack;
+ (BOOL)isMagicalSkill:(int)skillNumber;
+ (int)getRealIndexFromGameIndex:(int)index;
+ (NSString *)getDescriptionImageNameFromSkillIndex:(int)index;

@end
