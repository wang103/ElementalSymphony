//
//  MagicGold.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicBaseClass.h"

@interface MagicGold : MagicBaseClass 
{
	int hpReduced;
	int goldAdded;
	
	UIImageView *currentImageView;
	UIImage *animeImage1;
	UIImage *animeImage2;
	UIImage *animeImage3;
	UIImage *animeImage4;
	UIImage *animeImage5;
	UIImage *animeImage6;
}

@property int hpReduced;
@property int goldAdded;

@property (nonatomic, retain) UIImageView *currentImageView;
@property (nonatomic, retain) UIImage *animeImage1;
@property (nonatomic, retain) UIImage *animeImage2;
@property (nonatomic, retain) UIImage *animeImage3;
@property (nonatomic, retain) UIImage *animeImage4;
@property (nonatomic, retain) UIImage *animeImage5;
@property (nonatomic, retain) UIImage *animeImage6;

- (MagicGold *)init;
- (BOOL)displayNextAnimation;

@end
