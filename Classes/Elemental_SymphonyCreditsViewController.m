//
//  Elemental_SymphonyCreditsViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/1/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyCreditsViewController.h"

@implementation Elemental_SymphonyCreditsViewController

@synthesize goBackButton;

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

- (IBAction)switchViewToGoback:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
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
	
	self.goBackButton = nil;
}

- (void)dealloc
{
	[goBackButton release];
	
    [super dealloc];
}

@end
