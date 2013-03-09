//
//  MagicGold.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "MagicGold.h"
#import "UserInformation.h"

@implementation MagicGold

@synthesize hpReduced;
@synthesize goldAdded;
@synthesize currentImageView;
@synthesize animeImage1;
@synthesize animeImage2;
@synthesize animeImage3;
@synthesize animeImage4;
@synthesize animeImage5;
@synthesize animeImage6;

- (MagicGold *)init
{
	// Depends on level.
	UserInformation *UInfo = [UserInformation sharedManager];
	int level = [UInfo skills:6];
	if (level == 1)
		goldAdded = 100;
	else if (level == 2)
		goldAdded = 200;
	else if (level == 3)
		goldAdded = 350;
	else 
		goldAdded = 550;
	
	// Other initialization.
	animationCounter = 0;
	ready = YES;
	magicCost = MAGIC_GOLD_COST;
	hpReduced = 5;
	
	self.animeImage1 = [UIImage imageNamed:@"ES_Skills_Gold_01.png"];
	self.animeImage2 = [UIImage imageNamed:@"ES_Skills_Gold_02.png"];
	self.animeImage3 = [UIImage imageNamed:@"ES_Skills_Gold_03.png"];
	self.animeImage4 = [UIImage imageNamed:@"ES_Skills_Gold_04.png"];
	self.animeImage5 = [UIImage imageNamed:@"ES_Skills_Gold_05.png"];
	self.animeImage6 = [UIImage imageNamed:@"ES_Skills_Gold_06.png"];
	
	currentImageView = [[UIImageView alloc] initWithImage:animeImage1];
	CGRect frame = currentImageView.frame;
	frame.origin.x = 157;
	frame.origin.y = 419;
	currentImageView.frame = frame;
	
	return [super init];
}

// Set the image view to the next animation, this method is called 30 times/second.
// Return YES if the animation is done so this should be deleted.
- (BOOL)displayNextAnimation
{
	if (animationCounter < 7)
	{
		// do nothing.
	}
	else if (animationCounter < 15)
	{
		currentImageView.image = animeImage2;
	}
	else if (animationCounter < 22)
	{
		currentImageView.image = animeImage3;
	}
	else if (animationCounter < 30)
	{
		currentImageView.image = animeImage4;
	}
	else if (animationCounter < 37)
	{
		currentImageView.image = animeImage5;
	}
	else if (animationCounter < 45)
	{
		currentImageView.image = animeImage6;
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
	[animeImage6 release];
	[currentImageView release];
	
	[super dealloc];
}

@end
