//
//  Bullet.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 8/12/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Bullet : NSObject
{
	int attackPoint;
	UIImageView *bulletView;
	
	int lane;					// The lane number this bullet is in, 0 to 5.
	int type;					// The elemental type inherited from the unit.
	int condition;				// The special condition this bullet can cause.
	double criticalRate;		// The chances to activate special effect.
}

@property int attackPoint;
@property (nonatomic, retain) UIImageView *bulletView;
@property int lane;
@property int type;
@property int condition;
@property double criticalRate;

- (Bullet *)initWithBulletImage:(UIImage *)bulletImage :(int)attack :(int)laneNumber 
							   :(int)eType :(int)conditionEffect :(double)critical;

@end
