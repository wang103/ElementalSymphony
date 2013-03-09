//
//  MagicSnowLotus.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicBaseClass.h"

@class EnemyUnit;

@interface MagicSnowLotus : MagicBaseClass 
{
	int durationInSeconds;
	
	UIImageView *currentImageView1;
	UIImageView *currentImageView2;
	
	EnemyUnit *affectingEnemy;
}

@property int durationInSeconds;
@property (nonatomic, retain) UIImageView *currentImageView1;
@property (nonatomic, retain) UIImageView *currentImageView2;

- (MagicSnowLotus *)initWithAffectingEnemy:(EnemyUnit *)enemy;
- (BOOL)displayNextAnimation;
- (EnemyUnit *)getAffectingEnemy;

@end
