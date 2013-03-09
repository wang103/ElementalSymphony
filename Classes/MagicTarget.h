//
//  MagicTarget.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicBaseClass.h"

@class EnemyUnit;

@interface MagicTarget : MagicBaseClass 
{
	int durationInSeconds;
	
	UIImageView *currentImageView;	
	
	EnemyUnit *affectingEnemy;
}

@property int durationInSeconds;
@property (nonatomic, retain) UIImageView *currentImageView;

- (MagicTarget *)initWithEnemy:(EnemyUnit *)enemy;
- (BOOL)displayNextAnimation;
- (EnemyUnit *)getAffectingEnemy;

@end
