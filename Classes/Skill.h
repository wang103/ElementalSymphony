//
//  Skill.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Skill : NSObject <NSMutableCopying>
{
	int skillNumber;				// The unique number that represents the skill.
	
	BOOL isAvailable;				// Whether or not player can use this skill.
	int availableCounter;			// The counter for availablity.
	UIView *availablityView;		// The view to cover the image when unavailable.
	
	UIImageView *healthOutletView;	// The outlet for the health bar.
	UIImageView *healthImageView;	// The image view for the health bar.
	
	UIImageView *currentImageView;	// The current view of this unit the game should use.
	UIImageView *skillImage;		// The image of this skill on the skill list.
	UIImage *baseImage;				// The base image of this skill on the field.
	UIImage *setImage;				// The set image of this skill on the field.
	UIImage *moveImage;				// The move image of this skill on the field.
	UIImage *bulletImage;			// The bullet image.
	
	int dyingCounter;				// The counter for dying effect.
	UIImageView *dyingImageView;	// The view for dying effect.
	BOOL isDying;					// Whether or not this unit is dying.
	
	UIImageView *smallImage;		// The small icon image. (G or M).
	unsigned int amount;			// The cost of this skill.
	
	int element;					// The elemental type. It can be 0, 1, 2, 3, 4.
	int attack;						// Attack power.
	double totalHealth;				// Total health point.
	double health;					// Current health point.
	double dodgeRate;				// The chances of dodging.
	double criticalRate;			// The chances of special effect.
	int specialEffect;				// Represent the special effect this unit has.
	int attackFrequency;			// The frequency of attacking in seconds.
	int produceFrequency;			// The frequency of producing this unit in seconds.
	
	int attackCounter;				// For attacking move.
	int bulletCounter;				// For shooting bullet.
	BOOL isAttacking;				// Whether this unit is attacking or not.
	
	BOOL isProtected;				// Whether or not this unit is under protection of Magic Thorn.
}

@property (nonatomic, retain) UIView *availablityView;
@property (nonatomic, retain) UIImageView *healthOutletView;
@property (nonatomic, retain) UIImageView *healthImageView;
@property (nonatomic, retain) UIImageView *currentImageView;
@property (nonatomic, retain) UIImageView *skillImage;
@property (nonatomic, retain) UIImage *baseImage;
@property (nonatomic, retain) UIImage *setImage;
@property (nonatomic, retain) UIImage *moveImage;
@property (nonatomic, retain) UIImage *bulletImage;
@property (nonatomic, retain) UIImageView *dyingImageView;
@property (nonatomic, retain) UIImageView *smallImage;
@property int skillNumber;
@property BOOL isAvailable;
@property unsigned int amount;
@property int element;
@property int attack;
@property double totalHealth;
@property double health;
@property double dodgeRate;
@property double criticalRate;
@property int specialEffect;
@property int attackFrequency;
@property BOOL isDying;
@property BOOL isProtected;

- (Skill *)initWithSkillNumber:(int)number;
- (void)setCurrentImageViewTo:(UIImage *)image;
- (void)tryToMakeAvailable;
- (void)switchAttackImage;
- (void)resetImage;
- (BOOL)ableToAttack;
- (void)setIsAttacking:(BOOL)attacking;
- (BOOL)isAttacking;
- (void)reduceHealthBy:(double)lostHealthPoint;

- (BOOL)changeDyingImage;

@end
