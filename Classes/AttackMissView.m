//
//  AttackMissView.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/3/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "AttackMissView.h"

@implementation AttackMissView

@synthesize currentImageView;
@synthesize missImage1;
@synthesize missImage2;
@synthesize missImage3;
@synthesize missImage4;
@synthesize missImage5;

- (AttackMissView *)initWithLocation:(CGPoint)location
{
	counter = 0;
	
	self.missImage1 = [UIImage imageNamed:@"Miss_01.png"];
	self.missImage2 = [UIImage imageNamed:@"Miss_02.png"];
	self.missImage3 = [UIImage imageNamed:@"Miss_03.png"];
	self.missImage4 = [UIImage imageNamed:@"Miss_04.png"];
	self.missImage5 = [UIImage imageNamed:@"Miss_05.png"];

	currentImageView = [[UIImageView alloc] initWithImage:missImage1];
	
	CGRect frame = currentImageView.frame;
	frame.origin = location;
	currentImageView.frame = frame;
	
	return [super init];
}

// Switch to next animation image.
// Return YES if it's all done and should be released.
- (BOOL)switchToNextImage
{
	counter ++;
	
	if (counter <= 6 ) 
	{
		// Do nothing.
	}
	else if (counter <= 12)
	{
		currentImageView.image = self.missImage2;
	}
	else if (counter <= 18)
	{
		currentImageView.image = self.missImage3;
	}
	else if (counter <= 24)
	{
		currentImageView.image = self.missImage4;
	}
	else if (counter <= 30)
	{
		currentImageView.image = self.missImage5;
	}
	else
	{
		return YES;
	}
	
	return NO;
}

- (void)dealloc
{
	[missImage1 release];
	[missImage2 release];
	[missImage3 release];
	[missImage4 release];
	[missImage5 release];
	[currentImageView release];

	[super dealloc];
}

@end
