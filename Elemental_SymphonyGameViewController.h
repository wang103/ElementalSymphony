//
//  Elemental_SymphonyEnvViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Elemental_SymphonyGameMenuViewController;
@class Elemental_SymphonyGameOverViewController;
@class Elemental_SymphonyPrizeViewController;
@class Elemental_SymphonyArenaScoreViewController;
@class Skill;
@class EnemyUnit;
@class MagicBaseClass;
@class AVPlaybackSoundController;

@interface Elemental_SymphonyGameViewController : UIViewController 
{
	UILabel *firstAmount;
	UILabel *secondAmount;
	UILabel *thirdAmount;
	UILabel *fourthAmount;
	UILabel *fifthAmount;
	UILabel *sixthAmount;
	
	UIImageView *baseImage;		// Game base image, there are 5 possible images.
	
	UIButton *gameMenuButton;	// The button to see the game menu.
	
	Elemental_SymphonyGameMenuViewController *gameMenuViewController;
	Elemental_SymphonyGameOverViewController *gameOverViewController;
	Elemental_SymphonyPrizeViewController *prizeViewController;
	Elemental_SymphonyArenaScoreViewController *arenaScoreViewController;
	
	// Variables for the game logic.
	BOOL isPlaying;					// Indicates whether the game is in process.
	NSTimer *theTimer;				// Main timer.
	
	CGPoint touchPoint;				// Where the player first touched the screen.
	UIImageView *draggingImage;		// The image of skill shown while dragging.
	
	float health;
	UIImageView *healthImage;
	UILabel *healthLabel;
	float magic;
	UIImageView *magicImage;
	UILabel *magicLabel;
	UILabel *moneyLabel;
	int numberOfEnemies;
	int numberOfEnemiesKilled;
	UILabel *numberOfEnemiesLabel;
	
	Skill *skills[6];					// Six currently using skills.
	CGRect grids[8][6];					// Divide the whole battle field into 8*6 squares.
	int currentSkillNumber;				// The currently selected skill, 0 ~ 5.
	int selectedUsingSkill;				// The currently selected skill, 0 ~ 17.
	MagicBaseClass *currentMagic;		// Selected magic, nil if none.
	NSMutableArray *lowerMagicArray;	// The array containing all the magic in effect below all units.
	NSMutableArray *upperMagicArray;	// The array containing all the magic in effect above all units.
	double damageGrids[8][6];			// The health to reduce from the enemy on those grids.
	int gridX;							// When dragging, this is current grid's x.
	int gridY;							// When dragging, this is current grid's y.
	
	UILabel *specialFieldLabel;			// Label telling player the effect of special fields.
	int specialFieldIndicator;			// 0 to 3, indicate which parameter to increase.
	NSMutableArray *specialFields;		// The array containing all the special fields.
	
	Skill *battleFieldUnits[8][6];		// The 2D array of all the units on the battle field.
	UIView *gridView;					// The small white panel indicating current square.
	
	NSMutableArray *bulletArray;		// The array containing all the bullets on the field.
	
	NSMutableArray *enemyArray;			// The array containing all the enemies.
	NSMutableArray *enemiesOnField;		// The array containing the enemies on the field.
	int sortingCounter;					// Only sort all the enemies on field once per second.
	NSMutableArray *enemiesOnHPBar;		// The array containing the enemies attacking on the HP bar.
	BOOL enemiesInLane[6];				// Whether or not there are enemies in that lane.
	int enemyCounter;					// The counter for when to put down another enemy.
	int enemyFrequency;					// How long to wait before putting down another one.
	
	NSMutableArray *missingArray;		// The array containing all the miss views.
	
	double moonPowerModifier;			// Base is 1.0, each moon soldier adds 0.1 to it.
	
	// Records related:
	unsigned int money;
	int recruits;
	int magicSpells;
}

@property (nonatomic, retain) IBOutlet UIImageView *baseImage;
@property (nonatomic, retain) IBOutlet UIButton *gameMenuButton;
@property (nonatomic, retain) Elemental_SymphonyGameMenuViewController *gameMenuViewController;
@property (nonatomic, retain) Elemental_SymphonyGameOverViewController *gameOverViewController;
@property (nonatomic, retain) Elemental_SymphonyPrizeViewController *prizeViewController;
@property (nonatomic, retain) Elemental_SymphonyArenaScoreViewController *arenaScoreViewController;
@property (nonatomic, retain) IBOutlet UIImageView *healthImage;
@property (nonatomic, retain) IBOutlet UIImageView *magicImage;
@property (nonatomic, retain) IBOutlet UILabel *healthLabel;
@property (nonatomic, retain) IBOutlet UILabel *magicLabel;
@property (nonatomic, retain) IBOutlet UILabel *moneyLabel;
@property (nonatomic, retain) IBOutlet UILabel *numberOfEnemiesLabel;
@property (nonatomic, retain) UIImageView *draggingImage;
@property (nonatomic, retain) IBOutlet UILabel *firstAmount, *secondAmount, *thirdAmount, *fourthAmount, *fifthAmount, *sixthAmount;
@property (nonatomic, retain) IBOutlet UILabel *specialFieldLabel;

- (void)initializeGame;
- (void)initializeEnemies;
- (void)initializeEnemiesForArena;
- (void)putMoreEnemiesInArray;
- (void)initializeGroundFixing;
- (void)initializeGrids;
- (void)initializeTimer;
- (void)initializeSkills:(int *)skillNumbers;
- (void)gameLogic:(NSTimer *)timer;
- (void)gameEnded;

- (void)pauseGame;
- (void)resumeGame;

- (void)switchViewToMap;
- (IBAction)switchViewToGameMenu:(id)sender;
- (void)switchViewToGameOver;
- (void)switchViewToPrizeView;
- (void)switchViewToArenaScore;
- (void)updateHealth:(float)healthPointTaken;
- (void)updateMagic:(float)magicPointTaken;
- (void)updateMoney:(unsigned int)newMoney;
- (void)updateEnemiesNumber:(int)newNumber;

- (UIView *)drawGrid:(CGRect)rect;
- (void)addEnemyUnitToTheView:(EnemyUnit *)enemyUnit;
- (void)removeEnemyFromField:(EnemyUnit *)enemy;

- (int)getStageElement;
- (Skill *)getTheUnitInFrontOfThisEnemy:(EnemyUnit *)enemy;
- (void)makeMagicSkillUnavailable;

- (AVPlaybackSoundController *)theBGMObject;

@end
