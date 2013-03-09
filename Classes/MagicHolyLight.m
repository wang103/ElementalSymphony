//
//  MagicHolyLight.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "MagicHolyLight.h"
#import "UserInformation.h"

@implementation MagicHolyLight

@synthesize durationInSeconds;
@synthesize animeImage1;
@synthesize animeImage2;
@synthesize animeImage3;
@synthesize currentImageView;

- (MagicHolyLight *)initWithAffectingUnit:(Skill *)unit
{
	// Depends on level.
	UserInformation *UInfo = [UserInformation sharedManager];
	int level = [UInfo skills:8];
	if (level == 1)
		durationInSeconds = 8;
	else if (level == 2)
		durationInSeconds = 12;
	else if (level == 3)
		durationInSeconds = 18;
	else 
		durationInSeconds = 26;
	
	// Other initialization.
	affectingUnit = unit;
	animationCounter = 0;
	ready = YES;
	magicCost = MAGIC_HOLY_LIGHT;
	goUp = YES;
	
	self.animeImage1 = [UIImage imageNamed:@"ES_Unitseffect_Lighting01.png"];
	self.animeImage2 = [UIImage imageNamed:@"ES_Unitseffect_Lighting02.png"];
	self.animeImage3 = [UIImage imageNamed:@"ES_Unitseffect_Lighting03.png"];
	
	currentImageView = [[UIImageView alloc] initWithImage:animeImage1];
	
	return [super init];
}

// Set the image view to the next animation, this method is called 30 times/second.
// Return YES if the animation is done so this should be deleted.
- (BOOL)displayNextAnimation
{	
	animationCounter ++;
	
	if (animationCounter > 30 * durationInSeconds)
	{
		return YES;
	}
	
	if (animationCounter % 6 == 0)
	{
		if (currentImageView.image == animeImage1 || currentImageView.image == animeImage3) 
		{
			currentImageView.image = animeImage2;
		}
		else 
		{
			if (goUp)
			{
				currentImageView.image = animeImage3;
				goUp = NO;
			}
			else
			{
				currentImageView.image = animeImage1;
				goUp = YES;
			}
		}
	}
	
	return NO;
}

- (Skill *)getAffectingUnit
{
	return affectingUnit;
}

- (void)dealloc
{
	[currentImageView removeFromSuperview];
	
	[animeImage1 release];
	[animeImage2 release];
	[animeImage3 release];
	[currentImageView release];
	
	[super dealloc];
}

@end
