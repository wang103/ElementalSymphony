//
//  UnitCellInUpgrade.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/18/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitCellInUpgrade : NSObject 
{
	int skillNumber;		// 0 ~ 16.
	
	UIImage *iconImage;
	UIImage *baseImage;
}

@property (nonatomic, retain) UIImage *iconImage;
@property (nonatomic, retain) UIImage *baseImage;
@property int skillNumber;

- (UnitCellInUpgrade *)initWithSkillNum:(int)number;

@end
