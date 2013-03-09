//
//  Elemental_SymphonyGuideViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/2/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyGuideViewController.h"

@implementation Elemental_SymphonyGuideViewController

@synthesize pageLabel;
@synthesize prevPageButton;
@synthesize nextPageButton;
@synthesize contentImageView;
@synthesize goBackButton;

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
	// Set the content.
	[self setContentAccordingToCurrentPage];
	
	// Set the page number label.
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/13", currentPage];
	pageLabel.text = pageLabelString;
	
	// Set the buttons to initial state.
	if (currentPage == 1)
		prevPageButton.enabled = NO;
	else 
		prevPageButton.enabled = YES;
	
	if (currentPage == 13)
		nextPageButton.enabled = NO;
	else
		nextPageButton.enabled = YES;
	
	[super viewWillAppear:animated];
}

- (IBAction)switchViewToGoback:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)goToNextPage:(id)sender
{
	currentPage ++;
	
	// Change page number.
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/13", currentPage];
	pageLabel.text = pageLabelString;
	
	if (currentPage == 13) 
	{
		nextPageButton.enabled = NO;
	}
	
	if (prevPageButton.enabled == NO)
	{
		prevPageButton.enabled = YES;
	}
	
	// Reset the content.
	[self setContentAccordingToCurrentPage];
}

- (IBAction)gotoPrevPage:(id)sender
{
	currentPage --;
	
	// Change page number.
	NSString *pageLabelString = [NSString stringWithFormat:@"%i/13", currentPage];
	pageLabel.text = pageLabelString;
	
	if (currentPage == 1)
	{
		prevPageButton.enabled = NO;
	}
	
	if (nextPageButton.enabled == NO)
	{
		nextPageButton.enabled = YES;
	}
	
	// Reset the content.
	[self setContentAccordingToCurrentPage];
}

- (void)setContentAccordingToCurrentPage
{
	UIImage *contentImage = [UIImage imageNamed:[NSString stringWithFormat:@"Page_%02i.png", currentPage]];
	
	contentImageView.image = contentImage;
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
	
	self.pageLabel = nil;
	self.prevPageButton = nil;
	self.nextPageButton = nil;
	self.contentImageView = nil;
	self.goBackButton = nil;
}

- (void)dealloc
{
	[pageLabel release];
	[prevPageButton release];
	[nextPageButton release];
	[contentImageView release];
	[goBackButton release];
	
    [super dealloc];
}

@end
