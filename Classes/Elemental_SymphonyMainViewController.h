//
//  Elemental_SymphonyViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/17/10.
//  Copyright University of Illinois at Urbana-Champaign 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Elemental_SymphonyNameViewController;
@class Elemental_SymphonyMapViewController;
@class Elemental_SymphonyGuideViewController;
@class Elemental_SymphonyCreditsViewController;

@interface Elemental_SymphonyMainViewController : UIViewController 
{	
	UIButton *newGameButton;	// The button to start a new game.
	UIButton *loadGameButton;	// The button to load a saved game.
	UIButton *guideButton;		// The button to see the game guide.
	UIButton *creditsButton;	// The button to see the Credits.
	
	Elemental_SymphonyNameViewController *nameViewController;		// A view to enter player's name.
	Elemental_SymphonyMapViewController *mapViewController;			// A view to see the map.
	Elemental_SymphonyGuideViewController *guideViewController;		// A view to see the instruction guide.
	Elemental_SymphonyCreditsViewController *creditsViewController;	// A view to see credits.
}

@property (nonatomic, retain) IBOutlet UIButton *newGameButton;
@property (nonatomic, retain) IBOutlet UIButton *loadGameButton;
@property (nonatomic, retain) IBOutlet UIButton *guideButton;
@property (nonatomic, retain) IBOutlet UIButton *creditsButton;

@property (nonatomic, retain) Elemental_SymphonyNameViewController *nameViewController;
@property (nonatomic, retain) Elemental_SymphonyMapViewController *mapViewController;
@property (nonatomic, retain) Elemental_SymphonyGuideViewController *guideViewController;
@property (nonatomic, retain) Elemental_SymphonyCreditsViewController *creditsViewController;

- (IBAction)switchViewToEnterName:(id)sender;
- (IBAction)switchViewToMap:(id)sender;
- (IBAction)switchViewToGuide:(id)sender;
- (IBAction)switchViewToCredits:(id)sender;

@end