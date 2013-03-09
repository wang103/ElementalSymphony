//
//  MagicTreatment.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "MagicTreatment.h"
#import "UserInformation.h"

@implementation MagicTreatment

@synthesize currentImageView;
@synthesize animeImage1;
@synthesize animeImage2;
@synthesize animeImage3;
@synthesize animeImage4;
@synthesize animeImage5;
@synthesize animeImage6;
@synthesize animeImage7;
@synthesize animeImage8;
@synthesize animeImage9;

- (MagicTreatment *)init
{
	// Depends on level.
	UserInformation *UInfo = [UserInformation sharedManager];
	int level = [UInfo skills:14];
	if (level == 1)
		magicCost = 120;
	else if (level == 2)
		magicCost = 100;
	else if (level == 3)
		magicCost = 70;
	else 
		magicCost = 30;
	
	// Other initialization.
	animationCounter = 0;
	ready = YES;
	
	self.animeImage1 = [UIImage imageNamed:@"ES_Skills_HP_01.png"];
	self.animeImage2 = [UIImage imageNamed:@"ES_Skills_HP_02.png"];
	self.animeImage3 = [UIImage imageNamed:@"ES_Skills_HP_03.png"];
	self.animeImage4 = [UIImage imageNamed:@"ES_Skills_HP_04.png"];
	self.animeImage5 = [UIImage imageNamed:@"ES_Skills_HP_05.png"];
	self.animeImage6 = [UIImage imageNamed:@"ES_Skills_HP_06.png"];
	self.animeImage7 = [UIImage imageNamed:@"ES_Skills_HP_07.png"];
	self.animeImage8 = [UIImage imageNamed:@"ES_Skills_HP_08.png"];
	self.animeImage9 = [UIImage imageNamed:@"ES_Skills_HP_09.png"];
	
	currentImageView = [[UIImageView alloc] initWithImage:animeImage1];
	
	return [super init];
}

// Set the image view to the next animation, this method is called 30 times/second.
// Return YES if the animation is done so this should be deleted.
- (BOOL)displayNextAnimation
{
	if (animationCounter < 3)
	{
		// do nothing.
	}
	else if (animationCounter < 6)
	{
		currentImageView.image = animeImage2;
	}
	else if (animationCounter < 9)
	{
		currentImageView.image = animeImage3;
	}
	else if (animationCounter < 12)
	{
		currentImageView.image = animeImage4;
	}
	else if (animationCounter < 15)
	{
		currentImageView.image = animeImage5;
	}
	else if (animationCounter < 18)
	{
		currentImageView.image = animeImage6;
	}
	else if (animationCounter < 21)
	{
		currentImageView.image = animeImage7;
	}
	else if (animationCounter < 24)
	{
		currentImageView.image = animeImage8;
	}
	else if (animationCounter < 27)
	{
		currentImageView.image = animeImage9;
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
	[animeImage7 release];
	[animeImage8 release];
	[animeImage9 release];
	[currentImageView release];
	
	[super dealloc];
}

@end
