//
//  UnitCellInUpgrade.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/18/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "UnitCellInUpgrade.h"

@implementation UnitCellInUpgrade

@synthesize skillNumber;
@synthesize iconImage;
@synthesize baseImage;

// Constructor.
- (UnitCellInUpgrade *)initWithSkillNum:(int)number
{
	skillNumber = number;
	
	// Set up the images.
	NSString *iconImagePath;
	NSString *baseImagePath;
	switch (number)
	{
		// Currently there are 17 skills.
		
		case 0:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_TargetLock.png"];
			baseImagePath = [NSString stringWithString:@"Units_Targetlock.png"];
			break;
		case 1:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_UVflowerpowder.png"];
			baseImagePath = [NSString stringWithString:@"Units_UVflowerpowder.png"];
			break;
		case 2:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_Gladiator.png"];
			baseImagePath = [NSString stringWithString:@"Units_Gladiator.png"];
			break;
		case 3:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_Incendiaryunit.png"];
			baseImagePath = [NSString stringWithString:@"Units_Incendiaryunit.png"];
			break;
		case 4:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_Archer.png"];
			baseImagePath = [NSString stringWithString:@"Units_Archer.png"];
			break;
		case 5:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_Iceman.png"];
			baseImagePath = [NSString stringWithString:@"Units_Iceman.png"];
			break;
		case 6:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_GoldenTouch.png"];
			baseImagePath = [NSString stringWithString:@"Units_GoldenTouch.png"];
			break;
		case 7:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_VolcanicEruption.png"];
			baseImagePath = [NSString stringWithString:@"Units_VolvanicEruption.png"];
			break;
		case 8:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_HolyLight.png"];
			baseImagePath = [NSString stringWithString:@"Units_HolyLight.png"];
			break;
		case 9:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_BiochemicalEngineer.png"];
			baseImagePath = [NSString stringWithString:@"Units_BiochemicalEngineer.png"];
			break;
		case 10:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_Moonsoldier.png"];
			baseImagePath = [NSString stringWithString:@"Units_Moonsoldier.png"];
			break;
		case 11:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_Footsoldier.png"];
			baseImagePath = [NSString stringWithString:@"Units_FootSolider.png"];
			break;
		case 12:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_SnowLotus.png"];
			baseImagePath = [NSString stringWithString:@"Units_SnowLotus.png"];
			break;
		case 13:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_GuardianAngel.png"];
			baseImagePath = [NSString stringWithString:@"Units_GuardianAngel.png"];
			break;
		case 14:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_Health.png"];
			baseImagePath = [NSString stringWithString:@"Units_Health.png"];
			break;
		case 15:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_Fence.png"];
			baseImagePath = [NSString stringWithString:@"Units_Fence.png"];
			break;
		case 16:
			iconImagePath = [NSString stringWithString:@"ES_SkillLogo_New_Sorceress.png"];
			baseImagePath = [NSString stringWithString:@"Units_Sorceress.png"];
			break;
		default:
			break;
	}
	
	self.iconImage = [UIImage imageNamed:iconImagePath];	
	self.baseImage = [UIImage imageNamed:baseImagePath];
	
	return [super init];
}

- (void)dealloc
{
	[iconImage release];
	[baseImage release];
	
	[super dealloc];
}

@end
