//
//  MagicThorn.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/29/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicBaseClass.h"

@class Skill;

@interface MagicThorn : MagicBaseClass 
{
	int durationInSeconds;
	
	UIImageView *frontImageView;
	UIImageView *backImageView;

	UIImage *frontImage1;
	UIImage *backImage1;
	UIImage *frontImage2;
	UIImage *backImage2;
	
	UIImage *draggingImage;		// The image to display when still dragging on the view.
	
	Skill *affectingUnit;
}

@property int durationInSeconds;
@property (nonatomic, retain) UIImageView *frontImageView;
@property (nonatomic, retain) UIImageView *backImageView;
@property (nonatomic, retain) UIImage *frontImage1;
@property (nonatomic, retain) UIImage *backImage1;
@property (nonatomic, retain) UIImage *frontImage2;
@property (nonatomic, retain) UIImage *backImage2;
@property (nonatomic, retain) UIImage *draggingImage;

- (MagicThorn *)initWithUnit:(Skill *)unit;
- (BOOL)displayNextAnimation;
- (void)setUnit:(Skill *)unit;
- (Skill *)getUnit;

@end
