//
//  MagicThorn.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "MagicThorn.h"
#import "UserInformation.h"

@implementation MagicThorn

@synthesize durationInSeconds;
@synthesize frontImageView;
@synthesize backImageView;
@synthesize frontImage1;
@synthesize backImage1;
@synthesize frontImage2;
@synthesize backImage2;
@synthesize draggingImage;

- (MagicThorn *)initWithUnit:(Skill *)unit
{	
	// Depends on level.
	UserInformation *UInfo = [UserInformation sharedManager];
	int level = [UInfo skills:13];
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
	ready = NO;
	magicCost = MAGIC_THORN;
	
	self.frontImage1 = [UIImage imageNamed:@"ES_Skills_Thorn_Front.png"];
	self.backImage1 = [UIImage imageNamed:@"ES_Skills_Thorn_Back.png"];
	self.frontImage2 = [UIImage imageNamed:@"ES_Skills_Thorn_Front_Move.png"];
	self.backImage2 = [UIImage imageNamed:@"ES_Skills_Thorn_Back_Move.png"];
	self.draggingImage = [UIImage imageNamed:@"ES_Skills_Thorn_Gray.png"];
	
	frontImageView = [[UIImageView alloc] initWithImage:frontImage1];
	backImageView = [[UIImageView alloc] initWithImage:backImage1];

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
	
	if (animationCounter % 30 == 0)
	{
		if (frontImageView.image == frontImage1) 
		{
			frontImageView.image = frontImage2;
			backImageView.image = backImage2;
		}
		else 
		{
			frontImageView.image = frontImage1;
			backImageView.image = backImage1;
		}
	}
	
	return NO;
}

- (void)setUnit:(Skill *)unit
{
	affectingUnit = unit;
}

- (Skill *)getUnit
{
	return affectingUnit;
}

- (void)dealloc
{
	[frontImageView removeFromSuperview];
	[backImageView removeFromSuperview];
	
	[draggingImage release];
	[frontImage1 release];
	[backImage1 release];
	[frontImage2 release];
	[backImage2 release];
	[frontImageView release];
	[backImageView release];

	[super dealloc];
}

@end
