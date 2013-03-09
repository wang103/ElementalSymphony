//
//  Elemental_SymphonyViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/17/10.
//  Copyright University of Illinois at Urbana-Champaign 2010. All rights reserved.
//

#import "Elemental_SymphonyMainViewController.h"
#import "Elemental_SymphonyNameViewController.h"
#import "Elemental_SymphonyMapViewController.h"
#import "Elemental_SymphonyGuideViewController.h"
#import "Elemental_SymphonyCreditsViewController.h"
#import "GameUtils.h"

@implementation Elemental_SymphonyMainViewController

@synthesize newGameButton;
@synthesize loadGameButton;
@synthesize guideButton;
@synthesize creditsButton;
@synthesize nameViewController;
@synthesize mapViewController;
@synthesize guideViewController;
@synthesize creditsViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	[GameUtils startTimeCount];
	
	// Set up the button images.
	
	UIImage *newGameButtonNormal = [UIImage imageNamed:@"ES_UserInterface_Newgame.png"];
	[newGameButton setBackgroundImage:newGameButtonNormal forState:UIControlStateNormal];
	
	UIImage *newGameButtonPressed = [UIImage imageNamed:@"ES_UserInterface_Newgame_Press.png"];
	[newGameButton setBackgroundImage:newGameButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *loadGameButtonNormal = [UIImage imageNamed:@"ES_UserInterface_Loadgame.png"];
	[loadGameButton setBackgroundImage:loadGameButtonNormal forState:UIControlStateNormal];
	
	UIImage *loadGameButtonPressed = [UIImage imageNamed:@"ES_UserInterface_Loadgame_Press.png"];
	[loadGameButton setBackgroundImage:loadGameButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *guideButtonNormal = [UIImage imageNamed:@"ES_UserInterface_Gameguide.png"];
	[guideButton setBackgroundImage:guideButtonNormal forState:UIControlStateNormal];
	
	UIImage *guideButtonPressed = [UIImage imageNamed:@"ES_UserInterface_Gameguide_Press.png"];
	[guideButton setBackgroundImage:guideButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *creditsButtonNormal = [UIImage imageNamed:@"ES_UserInterface_Credits.png"];
	[creditsButton setBackgroundImage:creditsButtonNormal forState:UIControlStateNormal];
	
	UIImage *creditsButtonPressed = [UIImage imageNamed:@"ES_UserInterface_Credits_Press.png"];
	[creditsButton setBackgroundImage:creditsButtonPressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

// Switch to a view that player can enter the name.
- (IBAction)switchViewToEnterName:(id)sender
{	
	if(nameViewController == nil)
	{
		Elemental_SymphonyNameViewController *nameController = [[Elemental_SymphonyNameViewController alloc] initWithNibName:@"Elemental_SymphonyNameViewController" bundle:nil];
		self.nameViewController = nameController;
		[nameController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:nameViewController animated:YES];
}

// Switch to a view that player can see the map.
- (IBAction)switchViewToMap:(id)sender
{
	// Switch only if there is data.
	if([GameUtils dataExists] == NO)
	{
		// pop up a warning
		UIAlertView *dataAlert = [[UIAlertView alloc] initWithTitle:@"ERROR"
															message:@"NO EXISTING DATA DETECTED, PLEASE CREATE A NEW PROFILE."
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		
		[dataAlert show];
		[dataAlert release];
		
		return;
	}
	
	if(mapViewController == nil)
	{
		Elemental_SymphonyMapViewController *mapController = [[Elemental_SymphonyMapViewController alloc] initWithNibName:@"Elemental_SymphonyMapViewController" bundle:nil];
		self.mapViewController = mapController;
		[mapController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:mapViewController animated:YES];
}

// Switch to a view that player can see tutorial.
- (IBAction)switchViewToGuide:(id)sender
{
	if(guideViewController == nil)
	{
		Elemental_SymphonyGuideViewController *guideController = [[Elemental_SymphonyGuideViewController alloc] initWithNibName:@"Elemental_SymphonyGuideViewController" bundle:nil];
		self.guideViewController = guideController;
		[guideController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:guideViewController animated:YES];
}

// Switch to a view that player can see credits.
- (IBAction)switchViewToCredits:(id)sender
{
	if(creditsViewController == nil)
	{
		Elemental_SymphonyCreditsViewController *creditsController = [[Elemental_SymphonyCreditsViewController alloc] initWithNibName:@"Elemental_SymphonyCreditsViewController" bundle:nil];
		self.creditsViewController = creditsController;
		[creditsController release];
	}
	
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:creditsViewController animated:YES];
}

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	self.newGameButton = nil;
	self.loadGameButton = nil;
	self.guideButton = nil;
	self.creditsButton = nil;
	
	self.nameViewController = nil;
	self.mapViewController = nil;
	self.guideViewController = nil;
	self.creditsViewController = nil;
}

- (void)dealloc
{
	[newGameButton release];
	[loadGameButton release];
	[guideButton release];
	[creditsButton release];
	[nameViewController release];
	[mapViewController release];
	[guideViewController release];
	[creditsViewController release];
	
    [super dealloc];
}

@end
