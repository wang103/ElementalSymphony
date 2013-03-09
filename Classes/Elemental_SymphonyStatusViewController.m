//
//  Elemental_SymphonyStatusViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyStatusViewController.h"
#import "UserInformation.h"
#import "GameUtils.h"

@implementation Elemental_SymphonyStatusViewController

@synthesize goBackButton;
@synthesize nameField;
@synthesize killsField;
@synthesize deathsField;
@synthesize stageField;
@synthesize timeField;
@synthesize arenaField;
@synthesize rankField;
@synthesize airMedalImage;
@synthesize earthMedalImage;
@synthesize fireMedalImage;
@synthesize waterMedalImage;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Set the button images.
	
	UIImage *goBackImageNormal = [UIImage imageNamed:@"ES_Button_Back.png"];
	[goBackButton setBackgroundImage:goBackImageNormal forState:UIControlStateNormal];
	
	UIImage *goBackImagePressed = [UIImage imageNamed:@"ES_Button_Back_Press.png"];
	[goBackButton setBackgroundImage:goBackImagePressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	// Read user's information, set up the status view.
	
	UserInformation *UInfo = [UserInformation sharedManager];
	
	int currentArea = 0;
	int currentStage = 1;
	
	if([UInfo passedStages:4])
	{
		earthMedalImage.image = [UIImage imageNamed:@"ES_Medal_Earth.png"];
		currentArea = 5;
		currentStage ++;
	}
	if([UInfo passedStages:9])
	{	
		airMedalImage.image = [UIImage imageNamed:@"ES_Medal_Air.png"];
		currentArea = 10;
		currentStage ++;
	}
	if([UInfo passedStages:14])
	{
		waterMedalImage.image = [UIImage imageNamed:@"ES_Medal_Water.png"];
		currentArea = 15;
		currentStage ++;
	}
	if([UInfo passedStages:19])
	{
		fireMedalImage.image = [UIImage imageNamed:@"ES_Medal_Fire.png"];
		currentArea = 20;
		currentStage ++;
	}
	
	nameField.text = [NSString stringWithString: UInfo.name];
	killsField.text = [NSString stringWithFormat:@"%u", UInfo.numberKilled];
	deathsField.text = [NSString stringWithFormat:@"%u", UInfo.numberDeath];
	
	int subStagesNumber = 1;
	for (int i = currentArea; i < currentArea+4; ++i)
	{
		if([UInfo passedStages:i])
			subStagesNumber ++;
	}
	
	if(currentStage == 5)
		subStagesNumber = 1;
	
	stageField.text = [NSString stringWithFormat:@"%d-%d", currentStage, subStagesNumber];
	
	unsigned long totalSec = UInfo.time + [GameUtils getTimePassed];
	unsigned long min = totalSec / 60;
	unsigned long sec = totalSec - min * 60;
	unsigned long hrs = min / 60;
	min = min - hrs * 60;
	timeField.text = [NSString stringWithFormat:@"%lu:%lu:%lu", hrs, min, sec];
	
	arenaField.text = [NSString stringWithFormat:@"%u", UInfo.arenaScore];
	
	// Compute rank now.
	int numRep = (UInfo.numberKilled - (10 * UInfo.numberDeath)) / 600;
	char rank;
	if (numRep >= 4)
		rank = 'A';
	else if (numRep == 3)
		rank = 'B';
	else if (numRep == 2)
		rank = 'C';
	else if (numRep == 1)
		rank = 'D';
	else 
		rank = 'F';
	
	rankField.text = [NSString stringWithFormat:@"%c", rank];
	
	[super viewWillAppear:animated];
}

- (IBAction)switchViewToGoback:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.goBackButton = nil;
	self.nameField = nil;
	self.killsField = nil;
	self.deathsField = nil;
	self.stageField = nil;
	self.timeField = nil;
	self.arenaField = nil;
	self.rankField = nil;
	self.airMedalImage = nil;
	self.earthMedalImage = nil;
	self.fireMedalImage = nil;
	self.waterMedalImage = nil;
}

- (void)dealloc 
{
	[goBackButton release];
	[nameField release];
	[killsField release];
	[deathsField release];
	[stageField release];
	[timeField release];
	[arenaField release];
	[rankField release];
	[airMedalImage release];
	[earthMedalImage release];
	[fireMedalImage release];
	[waterMedalImage release];
	
    [super dealloc];
}

@end
