//
//  Elemental_SymphonyNameViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/25/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Elemental_SymphonyMapViewController;

@interface Elemental_SymphonyNameViewController : UIViewController
{
	UIButton *continueButton;	// The button to continue the game, load the map.
	UIButton *goBackButton;		// The button to go back to previous view, the main view.
	
	UITextField *nameField;		// The field for player to enter the name.
	
	Elemental_SymphonyMapViewController *mapViewController;
}

@property (nonatomic, retain) IBOutlet UIButton *continueButton;
@property (nonatomic, retain) IBOutlet UIButton *goBackButton;
@property (nonatomic, retain) IBOutlet UITextField *nameField;

@property (nonatomic, retain) Elemental_SymphonyMapViewController *mapViewController;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)switchViewToContinue:(id)sender;
- (IBAction)switchViewToGoBack:(id)sender;

@end
