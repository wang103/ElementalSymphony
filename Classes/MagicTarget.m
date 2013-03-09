//
//  MagicTarget.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "MagicTarget.h"
#import "UserInformation.h"

@implementation MagicTarget

@synthesize durationInSeconds;
@synthesize currentImageView;

- (MagicTarget *)initWithEnemy:(EnemyUnit *)enemy
{
	// Depends on level.
	UserInformation *UInfo = [UserInformation sharedManager];
	int level = [UInfo skills:0];
	if (level == 1)
		durationInSeconds = 10;
	else if (level == 2)
		durationInSeconds = 14;
	else if (level == 3)
		durationInSeconds = 20;
	else 
		durationInSeconds = 28;
	
	// Other initialization.
	affectingEnemy = enemy;	
	animationCounter = 0;
	ready = YES;
	magicCost = MAGIC_TARGET;
	
	UIImage *animeImage1 = [UIImage imageNamed:@"ES_Skills_Shot_Back.png"];	
	
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
		
	return NO;
}

- (EnemyUnit *)getAffectingEnemy
{
	return affectingEnemy;
}

- (void)dealloc
{
	[currentImageView removeFromSuperview];
	
	[currentImageView release];
	
	[super dealloc];
}

@end
