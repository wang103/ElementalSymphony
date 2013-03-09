//
//  MagicEruption.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/20/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicBaseClass.h"

@interface MagicEruption : MagicBaseClass 
{	
	int startRow;
	int startCol;
	
	double attack;				// Life lost for the enemy 30 times per second.
	
	UIImageView *currentImageView;
	UIImage *animeImage1;
	UIImage *animeImage2;
	UIImage *animeImage3;
	UIImage *animeImage4;
	UIImage *animeImage5;
	
	UIImage *draggingImage;		// The image to display when still dragging on the view.
}

@property int startRow;
@property int startCol;
@property double attack;
@property (nonatomic, retain) UIImageView *currentImageView;
@property (nonatomic, retain) UIImage *animeImage1;
@property (nonatomic, retain) UIImage *animeImage2;
@property (nonatomic, retain) UIImage *animeImage3;
@property (nonatomic, retain) UIImage *animeImage4;
@property (nonatomic, retain) UIImage *animeImage5;
@property (nonatomic, retain) UIImage *draggingImage;

- (MagicEruption *)init;
- (BOOL)displayNextAnimation;

@end
