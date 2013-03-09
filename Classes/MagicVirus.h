//
//  MagicVirus.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicBaseClass.h"

@interface MagicVirus : MagicBaseClass
{
	int startCol;
	
	double attack;				// Life lost for the enemy 30 times per second.
	
	UIImageView *currentImageView;
	
	UIImage *draggingImage;		// The image to display when still dragging on the view.
}

@property int startCol;
@property double attack;
@property (nonatomic, retain) UIImageView *currentImageView;
@property (nonatomic, retain) UIImage *draggingImage;

- (MagicVirus *)init;
- (BOOL)displayNextAnimation;

@end
