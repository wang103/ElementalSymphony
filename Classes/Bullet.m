//
//  Bullet.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 8/12/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

@synthesize attackPoint;
@synthesize bulletView;
@synthesize lane;
@synthesize type;
@synthesize condition;
@synthesize criticalRate;

- (Bullet *)initWithBulletImage:(UIImage *)bulletImage :(int)attack :(int)laneNumber 
							   :(int)eType :(int)conditionEffect :(double)critical
{
	bulletView = [[UIImageView alloc] initWithImage:bulletImage];
	attackPoint = attack;
	lane = laneNumber;
	type = eType;
	condition = conditionEffect;
	criticalRate = critical;
	
	return [super init];
}

- (void)dealloc
{
	[bulletView release];
	
	[super dealloc];
}

@end
