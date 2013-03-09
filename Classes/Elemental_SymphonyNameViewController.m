//
//  Elemental_SymphonyNameViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/25/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyNameViewController.h"
#import "Elemental_SymphonyMapViewController.h"
#import "GameUtils.h"
#import "UserInformation.h"

@implementation Elemental_SymphonyNameViewController

@synthesize continueButton;
@synthesize goBackButton;
@synthesize nameField;
@synthesize mapViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// Set up the button images.
	
	UIImage *continueButtonNormal = [UIImage imageNamed:@"ES_Button_NameContinue.png"];
	[continueButton setBackgroundImage:continueButtonNormal forState:UIControlStateNormal];
	
	UIImage *continueButtonPressed = [UIImage imageNamed:@"ES_Button_NameContinue_Press.png"];
	[continueButton setBackgroundImage:continueButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *goBackButtonNormal = [UIImage imageNamed:@"ES_Button_Goback.png"];
	[goBackButton setBackgroundImage:goBackButtonNormal forState:UIControlStateNormal];
	
	UIImage *goBackButtonPressed = [UIImage imageNamed:@"ES_Button_Goback_Press.png"];
	[goBackButton setBackgroundImage:goBackButtonPressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{	
	if([GameUtils dataExists])
	{
		// pop up a warning
		UIAlertView *dataAlert = [[UIAlertView alloc] initWithTitle:@"WARNING" 
															message:@"EXISTING DATA DETECTED, CREATING A NEW PROFILE WILL REMOVE THE OLD ONE. THIS ACTION CAN NOT BE REVERSED." 
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		
		[dataAlert show];
		[dataAlert release];
	}
	
	[super viewWillAppear:animated];
}	

- (IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}

- (IBAction)switchViewToContinue:(id)sender
{
	// retrive the input from the text field
	NSString *nameString = nameField.text;
	
	if([nameString length] < 1)
	{
		// pop up a warning
		UIAlertView *nameAlert = [[UIAlertView alloc] initWithTitle:@"ERROR" 
															message:@"THE NAME MUST BE AT LEAST ONE CHARACTER LONG." 
														   delegate:nil 
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		
		[nameAlert show];
		[nameAlert release];
	}
	else 
	{
		if(mapViewController == nil)
		{
			Elemental_SymphonyMapViewController *mapController = [[Elemental_SymphonyMapViewController alloc] initWithNibName:@"Elemental_SymphonyMapViewController" bundle:nil];
			self.mapViewController = mapController;
			[mapController release];
		}
		
		if(self.modalViewController)
			[self dismissModalViewControllerAnimated:NO];
		
		// Remove the old data if there is any.
		[GameUtils deleteDataFile];
		
		[UserInformation reset];
		UserInformation *UInfo = [UserInformation sharedManager];
		
		// store the name
		UInfo.name = nameField.text;
		
		// Save the data.
		[GameUtils saveTheGame];
		
		[self presentModalViewController:mapViewController animated:YES];
	}
}

- (IBAction)switchViewToGoBack:(id)sender
{
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	[self.parentViewController dismissModalViewControllerAnimated:YES];
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

	self.continueButton = nil;
	self.goBackButton = nil;
	self.nameField = nil;
	self.mapViewController = nil;
}

- (void)dealloc 
{
	[continueButton release];
	[goBackButton release];
	[nameField release];
	[mapViewController release];
	
    [super dealloc];
}

@end
