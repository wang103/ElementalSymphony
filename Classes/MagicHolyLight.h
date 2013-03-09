//
//  MagicHolyLight.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicBaseClass.h"

@class Skill;

@interface MagicHolyLight : MagicBaseClass 
{
	int durationInSeconds;
	
	UIImage *animeImage1;
	UIImage *animeImage2;
	UIImage *animeImage3;
	UIImageView *currentImageView;
	
	Skill *affectingUnit;
	
	BOOL goUp;
}

@property int durationInSeconds;
@property (nonatomic, retain) UIImage *animeImage1;
@property (nonatomic, retain) UIImage *animeImage2;
@property (nonatomic, retain) UIImage *animeImage3;
@property (nonatomic, retain) UIImageView *currentImageView;

- (MagicHolyLight *)initWithAffectingUnit:(Skill *)unit;
- (BOOL)displayNextAnimation;
- (Skill *)getAffectingUnit;

@end
