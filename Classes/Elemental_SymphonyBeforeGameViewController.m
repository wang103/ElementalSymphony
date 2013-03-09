//
//  Elemental_SymphonyBeforeGameViewController.m
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/1/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import "Elemental_SymphonyAppDelegate.h"
#import "Elemental_SymphonyBeforeGameViewController.h"
#import "Elemental_SymphonyGameViewController.h"
#import "AVPlaybackSoundController.h"
#import "GameUtils.h"

@implementation Elemental_SymphonyBeforeGameViewController

@synthesize stageLabel;
@synthesize continueButton;
@synthesize goBackButton;
@synthesize gameViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	fakeButtonImageView = [[UIImageView alloc] init];

	// Set up the button images.
	
	UIImage *continueButtonNormal = [UIImage imageNamed:@"ES_Button_GameContinue.png"];
	[continueButton setBackgroundImage:continueButtonNormal forState:UIControlStateNormal];
	
	UIImage *continueButtonPressed = [UIImage imageNamed:@"ES_Button_GameContinue_Press.png"];
	[continueButton setBackgroundImage:continueButtonPressed forState:UIControlStateHighlighted];
	
	UIImage *goBackButtonNormal = [UIImage imageNamed:@"ES_Button_GameGoback.png"];
	[goBackButton setBackgroundImage:goBackButtonNormal forState:UIControlStateNormal];
	
	UIImage *goBackButtonPressed = [UIImage imageNamed:@"ES_Button_GameGoback_Press.png"];
	[goBackButton setBackgroundImage:goBackButtonPressed forState:UIControlStateHighlighted];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	int stage = [GameUtils getCurrentGameStage];

	// Set up the stage label.
	NSString *stageString = nil;
	if (stage == 20)
	{
		// Arena.
		stageString = [NSString stringWithString:@"ARENA"];		
	}
	else 
	{
		int area = stage / 5;
		area ++;
		int subStage = stage % 5 + 1;
		
		stageString = [NSString stringWithFormat:@"STAGE %i-%i", area, subStage];		
	}
	stageLabel.text = stageString;
	
	// Set up the fake stage button image.
	UIImage *fakeButtonImage = nil;
	if (stage == 4 || stage == 9 || stage == 14 || stage == 19 || stage == 20)
	{
		fakeButtonImage = [UIImage imageNamed:@"ES_BossStage_Open.png"];
	}
	else 
	{
		fakeButtonImage = [UIImage imageNamed:@"ES_SmallStage_Open.png"];
	}
	fakeButtonImageView.image = fakeButtonImage;
	
	// Set the image's size and location.
	switch (stage) 
	{
		case 0:
			fakeButtonImageView.frame = CGRectMake(70.0, 299.0, 30.0, 30.0);
			break;
		case 1:
			fakeButtonImageView.frame = CGRectMake(23.0, 240.0, 30.0, 30.0);
			break;
		case 2:
			fakeButtonImageView.frame = CGRectMake(28.0, 198.0, 30.0, 30.0);
			break;
		case 3:
			fakeButtonImageView.frame = CGRectMake(76.0, 243.0, 30.0, 30.0);
			break;
		case 4:
			fakeButtonImageView.frame = CGRectMake(140.0, 265.0, 30.0, 30.0);
			break;
		case 5:
			fakeButtonImageView.frame = CGRectMake(183.0, 217.0, 30.0, 30.0);
			break;
		case 6:
			fakeButtonImageView.frame = CGRectMake(112.0, 212.0, 30.0, 30.0);
			break;
		case 7:
			fakeButtonImageView.frame = CGRectMake(272.0, 188.0, 30.0, 30.0);
			break;
		case 8:
			fakeButtonImageView.frame = CGRectMake(223.0, 140.0, 30.0, 30.0);
			break;
		case 9:
			fakeButtonImageView.frame = CGRectMake(182.0, 179.0, 30.0, 30.0);
			break;
		case 10:
			fakeButtonImageView.frame = CGRectMake(146.0, 148.0, 30.0, 30.0);
			break;
		case 11:
			fakeButtonImageView.frame = CGRectMake(220.0, 96.0, 30.0, 30.0);
			break;
		case 12:
			fakeButtonImageView.frame = CGRectMake(156.0, 82.0, 30.0, 30.0);
			break;
		case 13:
			fakeButtonImageView.frame = CGRectMake(97.0, 120.0, 30.0, 30.0);
			break;
		case 14:
			fakeButtonImageView.frame = CGRectMake(45.0, 131.0, 30.0, 30.0);
			break;
		case 15:
			fakeButtonImageView.frame = CGRectMake(43.0, 83.0, 30.0, 30.0);
			break;
		case 16:
			fakeButtonImageView.frame = CGRectMake(60.0, 11.0, 30.0, 30.0);
			break;
		case 17:
			fakeButtonImageView.frame = CGRectMake(98.0, 52.0, 30.0, 30.0);
			break;
		case 18:
			fakeButtonImageView.frame = CGRectMake(169.0, 32.0, 30.0, 30.0);
			break;
		case 19:
			fakeButtonImageView.frame = CGRectMake(221.0, 35.0, 30.0, 30.0);
			break;
		case 20:
			fakeButtonImageView.frame = CGRectMake(259.0, 75.0, 30.0, 30.0);
			break;
		default:
			break;
	}
	
	[self.view addSubview:fakeButtonImageView];
	
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[fakeButtonImageView removeFromSuperview];
	
	[super viewWillDisappear:animated];
}

- (AVPlaybackSoundController *)theBGMObject
{
	id theDelegate = [UIApplication sharedApplication].delegate;
	AVPlaybackSoundController *theBGMController;
	theBGMController = ((Elemental_SymphonyAppDelegate *)theDelegate).avPlaybackSoundController;
	return theBGMController;
}

// Switch view to play game.
- (IBAction)switchViewToGame:(id)sender
{	
	// Switch and prepare BGM.
	AVPlaybackSoundController *BGMController = [self theBGMObject];
	[BGMController switchBackgroundMusic:1];
	
	// Switch view.
	if(self.modalViewController)
		[self dismissModalViewControllerAnimated:NO];
	
	// Create a new view for this every game.
	Elemental_SymphonyGameViewController *gameController = [[Elemental_SymphonyGameViewController alloc] initWithNibName:@"Elemental_SymphonyEnvViewController" bundle:nil];
	self.gameViewController = gameController;
	[gameController release];
	
	[self presentModalViewController:gameViewController animated:YES];
}

- (IBAction)switchViewBackToMap:(id)sender
{
	// Go back without animation.
	[self.parentViewController dismissModalViewControllerAnimated:NO];
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
	
	self.stageLabel = nil;
	self.continueButton = nil;
	self.goBackButton = nil;
	self.gameViewController = nil;
}

- (void)dealloc
{
	[stageLabel release];
	[continueButton release];
	[goBackButton release];
	[gameViewController release];
	
    [super dealloc];
}


@end
