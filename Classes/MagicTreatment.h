//
//  MagicTreatment.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicBaseClass.h"

@interface MagicTreatment : MagicBaseClass 
{
	UIImageView *currentImageView;
	UIImage *animeImage1;
	UIImage *animeImage2;
	UIImage *animeImage3;
	UIImage *animeImage4;
	UIImage *animeImage5;
	UIImage *animeImage6;
	UIImage *animeImage7;
	UIImage *animeImage8;
	UIImage *animeImage9;	
}

@property (nonatomic, retain) UIImageView *currentImageView;
@property (nonatomic, retain) UIImage *animeImage1;
@property (nonatomic, retain) UIImage *animeImage2;
@property (nonatomic, retain) UIImage *animeImage3;
@property (nonatomic, retain) UIImage *animeImage4;
@property (nonatomic, retain) UIImage *animeImage5;
@property (nonatomic, retain) UIImage *animeImage6;
@property (nonatomic, retain) UIImage *animeImage7;
@property (nonatomic, retain) UIImage *animeImage8;
@property (nonatomic, retain) UIImage *animeImage9;

- (MagicTreatment *)init;
- (BOOL)displayNextAnimation;

@end
