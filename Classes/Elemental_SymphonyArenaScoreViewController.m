//
//  Elemental_SymphonyArenaScoreViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/6/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyArenaScoreViewController.h"
#import "UserInformation.h"
#import "GameUtils.h"

@implementation Elemental_SymphonyArenaScoreViewController

@synthesize killsLabel;
@synthesize recruitsLabel;
@synthesize magicSpellsLabel;
@synthesize goldLabel;
@synthesize pointLabel;
@synthesize continueButton;
@synthesize kills;
@synthesize recruits;
@synthesize magic;
@synthesize gold;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Set the button images.
	UIImage *continueNormal = [UIImage imageNamed:@"ES_Button_ClearedContinue.png"];
	[continueButton setBackgroundImage:continueNormal forState:UIControlStateNormal];
	
	UIImage *continuePressed = [UIImage imageNamed:@"ES_Button_ClearedContinue_Press.png"];
	[continueButton setBackgroundImage:continuePressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	killsLabel.text = [NSString stringWithFormat:@"%i", kills];
	recruitsLabel.text = [NSString stringWithFormat:@"%i", recruits];
	magicSpellsLabel.text = [NSString stringWithFormat:@"%i", magic];
	goldLabel.text = [NSString stringWithFormat:@"%i", gold];
	
	// Calculate score.
	int summoned = magic + recruits;
	if (summoned == 0)
	{
		summoned = 1;
	}
	int score = (int)( (kills * 100.0) / summoned + (gold / 50.0) );
	pointLabel.text = [NSString stringWithFormat:@"%i", score];
	
	// Update the arena score.
	UserInformation *UInfo = [UserInformation sharedManager];
	
	if (score > UInfo.arenaScore)
	{
		UInfo.arenaScore = score;
	}
	
	[super viewWillAppear:animated];
}

// This method is called when the continue button is clicked.
- (IBAction)continueButtonClicked:(id)sender
{
	// Save the game.
	[GameUtils saveTheGame];
	
	// pop up a message
	UIAlertView *saveMessage = [[UIAlertView alloc] initWithTitle:@"DATA SAVED" 
														  message:@"YOUR GAME HAS BEEN SAVED." 
														 delegate:nil
												cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
	[saveMessage show];
	[saveMessage release];
	
	// Go to the map view.
	// Current parent view is the game view, game view's parent view is the confirm view,
	// confirm view's parent view is the map view.
	[self.parentViewController.parentViewController.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.killsLabel = nil;
	self.recruitsLabel = nil;
	self.magicSpellsLabel = nil;
	self.goldLabel = nil;
	self.pointLabel = nil;
	self.continueButton = nil;
}

- (void)dealloc 
{
	
	[killsLabel release];
	[recruitsLabel release];
	[magicSpellsLabel release];
	[goldLabel release];
	[pointLabel release];
	[continueButton release];
	
    [super dealloc];
}

@end
