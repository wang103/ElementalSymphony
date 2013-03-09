//
//  Elemental_SymphonyGameOverViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 7/17/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyGameOverViewController.h"

@implementation Elemental_SymphonyGameOverViewController

@synthesize screenButton;

// Switch the view to the main view (the initial one).
- (IBAction)switchViewToMainView:(id)sender
{
	UIViewController *root = self;
	while (root.parentViewController != nil)
	{
		root = root.parentViewController;
	}
	
	[root dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.screenButton = nil;
}

- (void)dealloc 
{
	[screenButton release];
	
    [super dealloc];
}

@end
