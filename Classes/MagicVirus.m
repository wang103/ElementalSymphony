//
//  MagicVirus.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "MagicVirus.h"
#import "UserInformation.h"

@implementation MagicVirus

@synthesize startCol;
@synthesize attack;
@synthesize currentImageView;
@synthesize draggingImage;

- (MagicVirus *)init
{
	// Depends on level.
	UserInformation *UInfo = [UserInformation sharedManager];
	int level = [UInfo skills:1];
	if (level == 1)
		attack = 0.1;
	else if (level == 2)
		attack = 0.2;
	else if (level == 3)
		attack = 0.3;
	else 
		attack = 0.4;
		
	// Other initialization.
	animationCounter = 0;
	ready = NO;
	magicCost = MAGIC_VIRUS;
	
	UIImage *animeImage1 = [UIImage imageNamed:@"ES_Skills_PoisonLand.png"];
	self.draggingImage = [UIImage imageNamed:@"ES_Skills_PoisonLand_Gray.png"];
		
	currentImageView = [[UIImageView alloc] initWithImage:animeImage1];
	
	return [super init];
}

// Set the image view to the next animation, this method is called 30 times/second.
// Return YES if the animation is done so this should be deleted.
- (BOOL)displayNextAnimation
{
	animationCounter ++;

	if (animationCounter > 900)		// 900 indicates 30 seconds.
	{
		return YES;
	}
		
	return NO;
}

- (void)dealloc
{
	[currentImageView removeFromSuperview];
	
	[draggingImage release];
	[currentImageView release];
	
	[super dealloc];
}

@end
