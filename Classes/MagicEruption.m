//
//  MagicEruption.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/20/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "MagicEruption.h"
#import "UserInformation.h"

@implementation MagicEruption

@synthesize startRow;
@synthesize startCol;
@synthesize attack;
@synthesize currentImageView;
@synthesize animeImage1;
@synthesize animeImage2;
@synthesize animeImage3;
@synthesize animeImage4;
@synthesize animeImage5;
@synthesize draggingImage;

- (MagicEruption *)init
{
	// Depends on level.
	UserInformation *UInfo = [UserInformation sharedManager];
	int level = [UInfo skills:7];
	if (level == 1)
		attack = 1.0;
	else if (level == 2)
		attack = 1.1;
	else if (level == 3)
		attack = 1.2;
	else 
		attack = 1.3;
	
	// Other initialization.
	animationCounter = 0;
	ready = NO;
	magicCost = MAGIC_ERUPTION_COST;
	
	self.animeImage1 = [UIImage imageNamed:@"ES_Skills_Burn_01.png"];
	self.animeImage2 = [UIImage imageNamed:@"ES_Skills_Burn_02.png"];
	self.animeImage3 = [UIImage imageNamed:@"ES_Skills_Burn_03.png"];
	self.animeImage4 = [UIImage imageNamed:@"ES_Skills_Burn_04.png"];
	self.animeImage5 = [UIImage imageNamed:@"ES_Skills_Burn_05.png"];
	self.draggingImage = [UIImage imageNamed:@"ES_Skills_Burn_Gray.png"];
	
	currentImageView = [[UIImageView alloc] initWithImage:animeImage1];
	
	return [super init];
}

// Set the image view to the next animation, this method is called 30 times/second.
// Return YES if the animation is done so this should be deleted.
- (BOOL)displayNextAnimation
{
	if (animationCounter < 6)
	{
		// do nothing.
	}
	else if (animationCounter < 12)
	{
		currentImageView.image = animeImage2;
	}
	else if (animationCounter < 18)
	{
		currentImageView.image = animeImage3;
	}
	else if (animationCounter < 24)
	{
		currentImageView.image = animeImage4;
	}
	else if (animationCounter < 54)
	{
		currentImageView.image = animeImage5;
	}
	else if (animationCounter < 60)
	{
		currentImageView.image = animeImage4;
	}
	else if (animationCounter < 66)
	{
		currentImageView.image = animeImage3;
	}
	else if (animationCounter < 72)
	{
		currentImageView.image = animeImage2;
	}
	else if (animationCounter < 78)
	{
		currentImageView.image = animeImage1;
	}
	else
	{
		return YES;
	}
	
	animationCounter ++;
	
	return NO;
}

- (void)dealloc
{
	[currentImageView removeFromSuperview];
	
	[animeImage1 release];
	[animeImage2 release];
	[animeImage3 release];
	[animeImage4 release];
	[animeImage5 release];
	[draggingImage release];
	[currentImageView release];
	
	[super dealloc];
}

@end
