//
//  MagicSnowLotus.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "MagicSnowLotus.h"
#import "UserInformation.h"

@implementation MagicSnowLotus

@synthesize durationInSeconds;
@synthesize currentImageView1;
@synthesize currentImageView2;

- (MagicSnowLotus *)initWithAffectingEnemy:(EnemyUnit *)enemy
{
	// Depends on level.
	UserInformation *UInfo = [UserInformation sharedManager];
	int level = [UInfo skills:12];
	if (level == 1)
		durationInSeconds = 5;
	else if (level == 2)
		durationInSeconds = 8;
	else if (level == 3)
		durationInSeconds = 13;
	else 
		durationInSeconds = 20;
	
	// Other initialization.
	affectingEnemy = enemy;
	animationCounter = 0;
	ready = YES;
	magicCost = MAGIC_SNOW_LOTUS;
	
	UIImage *animeImage1 = [UIImage imageNamed:@"ES_Skills_Snow_Back.png"];
	UIImage *animeImage2 = [UIImage imageNamed:@"ES_Skills_Snow_Front.png"];
		
	currentImageView1 = [[UIImageView alloc] initWithImage:animeImage1];
	currentImageView2 = [[UIImageView alloc] initWithImage:animeImage2];

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
	
	return NO;
}

- (EnemyUnit *)getAffectingEnemy
{
	return affectingEnemy;
}

- (void)dealloc
{
	[currentImageView1 removeFromSuperview];
	[currentImageView2 removeFromSuperview];
	
	[currentImageView1 release];
	[currentImageView2 release];

	[super dealloc];
}

@end
