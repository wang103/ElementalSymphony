//
//  AttackMissView.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/3/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttackMissView : NSObject 
{
	int counter;
	
	UIImageView *currentImageView;
	UIImage *missImage1;
	UIImage *missImage2;
	UIImage *missImage3;
	UIImage *missImage4;
	UIImage *missImage5;
}

@property (nonatomic, retain) UIImageView *currentImageView;
@property (nonatomic, retain) UIImage *missImage1;
@property (nonatomic, retain) UIImage *missImage2;
@property (nonatomic, retain) UIImage *missImage3;
@property (nonatomic, retain) UIImage *missImage4;
@property (nonatomic, retain) UIImage *missImage5;

- (AttackMissView *)initWithLocation:(CGPoint)location;
- (BOOL)switchToNextImage;

@end
