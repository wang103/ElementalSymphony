//
//  EnemyUnit.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnemyUnit : NSObject 
{
	int element;			// 0 to 3;
	
	BOOL conditions[8];		// Special conditions this enemy is in.
	
	UIImageView *healthOutletView;	// The outlet for the health bar.
	UIImageView *healthImageView;	// The image view for the health bar.
	
	int attack;				// The attack point for this enemy.
	double totalHealth;		// The total health point for this enemy.
	double health;			// The current health point for this enemy.
	double speed;			// The walking speed for this enemy.
	double dodgeRate;		// The dodge rate for this enemy.
	int attackFrequency;	// The frequeny of attacking in seconds.
	
	UIImageView *currentImageView;
	UIImage *walkImage1;
	UIImage *walkImage2;
	UIImage *walkImage3;
	UIImage *attackImage1;
	UIImage *attackImage2;
	UIImage *attackImage3;
	UIImage *attackImage4;
	UIImageView *conditionImageView;
	
	int lane;				// The lane number this enemy is in: 0 to 5.
	
	int walkAnimeCounter;	// The counter for walking animation.
	int conditionCounter;	// The counter for special condition.
	
	BOOL isAttacking;
	int ableToAttackCounter;	// The counter for when is able to attack.
	int attackAnimeCounter;		// The counter for attacking animation.
}

@property (nonatomic, retain) UIImageView *healthOutletView;
@property (nonatomic, retain) UIImageView *healthImageView;
@property (nonatomic, retain) UIImageView *currentImageView;
@property (nonatomic, retain) UIImageView *conditionImageView;
@property (nonatomic, retain) UIImage *walkImage1;
@property (nonatomic, retain) UIImage *walkImage2;
@property (nonatomic, retain) UIImage *walkImage3;
@property (nonatomic, retain) UIImage *attackImage1;
@property (nonatomic, retain) UIImage *attackImage2;
@property (nonatomic, retain) UIImage *attackImage3;
@property (nonatomic, retain) UIImage *attackImage4;

@property int element;
@property int attack;
@property double health;
@property double speed;
@property double dodgeRate;
@property int lane;
@property BOOL isAttacking;
@property int conditionCounter;

- (EnemyUnit *)initWithEnemyNumber:(int)number;
- (void)switchToNextWalkingAnimation;
- (NSComparisonResult)comparatorForEnemy:(EnemyUnit *)e;
- (void)reductHealthBy:(double)lostHealthPoint;

- (BOOL)isAbleToAttack;
- (void)switchToAttackMode;
- (void)switchToNextAttackAnimation;

- (void)setCondition:(int)index withBoolean:(BOOL)boolean;
- (void)clearUnitConditions;
- (BOOL)getCondition:(int)index;

@end
