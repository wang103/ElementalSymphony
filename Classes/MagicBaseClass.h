//
//  MagicBaseClass.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * MAGIC_TREATMENT's cost depends on its level.
 */
#define MAGIC_ERUPTION_COST	50
#define MAGIC_GOLD_COST		30
#define MAGIC_VIRUS			40
#define MAGIC_SNOW_LOTUS	50
#define MAGIC_HOLY_LIGHT	40
#define MAGIC_TARGET		30
#define MAGIC_THORN			30

@interface MagicBaseClass : NSObject 
{
	int animationCounter;
	BOOL ready;					// Whether or not this magic is in the right place to release.
	int magicCost;
}

@property BOOL ready;
@property int magicCost;

@end
