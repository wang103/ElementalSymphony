//
//  Elemental_SymphonyInfoViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/2/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyInfoViewController.h"
#import "GameUtils.h"
#import "UserInformation.h"

@implementation Elemental_SymphonyInfoViewController

@synthesize prevPageButton;
@synthesize nextPageButton;
@synthesize goBackButton;
@synthesize skillView1;
@synthesize skillView2;
@synthesize pageLabel;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Initialization.
	currentPage = 1;
	
	// Set up the GUI components.
	
	UIImage *previousPageButtonNormal = [UIImage imageNamed:@"ES_Button_PreviousPage.png"];
	[prevPageButton setBackgroundImage:previousPageButtonNormal forState:UIControlStateNormal];
	
	UIImage *previousPageButtonPressed = [UIImage imageNamed:@"ES_Button_PreviousPage_Press.png"];
	[prevPageButton setBackgroundImage:previousPageButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *nextPageButtonNormal = [UIImage imageNamed:@"ES_Button_NextPage.png"];
	[nextPageButton setBackgroundImage:nextPageButtonNormal forState:UIControlStateNormal];
	
	UIImage *nextPageButtonPressed = [UIImage imageNamed:@"ES_Button_NextPage_Press.png"];
	[nextPageButton setBackgroundImage:nextPageButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *goBackButtonNormal = [UIImage imageNamed:@"ES_Button_Back.png"];
	[goBackButton setBackgroundImage:goBackButtonNormal forState:UIControlStateNormal];
	
	UIImage *goBackButtonPressed = [UIImage imageNamed:@"ES_Button_Back_Press.png"];
	[goBackButton setBackgroundImage:goBackButtonPressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	// Set the 2 cells.
	[self setTwoCellsAccordingToCurrentPage];
	
	// Set the page number label.
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/9", currentPage];
	pageLabel.text = pageLabelString;
	
	// Set the buttons to initial state.
	if (currentPage == 1)
		prevPageButton.enabled = NO;
	else 
		prevPageButton.enabled = YES;
	
	if (currentPage == 9)
		nextPageButton.enabled = NO;
	else
		nextPageButton.enabled = YES;
	
	[super viewWillAppear:animated];
}

// Set the two skill description according to the value of currentPage.
- (void)setTwoCellsAccordingToCurrentPage
{
	UserInformation *UInfo = [UserInformation sharedManager];
	
	int index = (currentPage - 1) * 2;
	
	// First one.
	UIImage *image1 = nil;
	if ([UInfo skills:[GameUtils getRealIndexFromGameIndex:index]] == 0)
	{
		image1 = [UIImage imageNamed:@"ES_StageCleared_Locked.png"];
	}
	else
	{
		image1 = [UIImage imageNamed:[GameUtils getDescriptionImageNameFromSkillIndex:index]];
	}
	skillView1.image = image1;
	
	index ++;
	if (index == 17)
	{
		skillView2.image = nil;
		return;
	}
	
	// Second one.
	UIImage *image2 = nil;
	if ([UInfo skills:[GameUtils getRealIndexFromGameIndex:index]] == 0)
	{
		image2 = [UIImage imageNamed:@"ES_StageCleared_Locked.png"];
	}
	else
	{
		image2 = [UIImage imageNamed:[GameUtils getDescriptionImageNameFromSkillIndex:index]];
	}
	skillView2.image = image2;
}

// Go back to the map view.
- (IBAction)switchViewToGoback:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

// Show the next two skills description.
- (IBAction)goToNextPage:(id)sender
{
	currentPage ++;
	
	// Change page number.
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/9", currentPage];
	pageLabel.text = pageLabelString;
	
	if (currentPage == 9) 
	{
		nextPageButton.enabled = NO;
	}
	
	if (prevPageButton.enabled == NO)
	{
		prevPageButton.enabled = YES;
	}
	
	// Reset the 2 cells.
	[self setTwoCellsAccordingToCurrentPage];
}

// Show the previous two skills description.
- (IBAction)gotoPrevPage:(id)sender
{
	currentPage --;
	
	// Change page number.
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/9", currentPage];
	pageLabel.text = pageLabelString;
	
	if (currentPage == 1)
	{
		prevPageButton.enabled = NO;
	}
	
	if (nextPageButton.enabled == NO)
	{
		nextPageButton.enabled = YES;
	}
	
	// Reset the 2 cells.
	[self setTwoCellsAccordingToCurrentPage];
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
	
	self.prevPageButton = nil;
	self.nextPageButton = nil;
	self.goBackButton = nil;
	self.skillView1 = nil;
	self.skillView2 = nil;
	self.pageLabel = nil;
}

- (void)dealloc
{
	[prevPageButton release];
	[nextPageButton release];
	[goBackButton release];
	[skillView1 release];
	[skillView2 release];
	[pageLabel release];
	
    [super dealloc];
}

@end
