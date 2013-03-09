//
//  Elemental_SymphonyStatusViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 5/27/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Elemental_SymphonyStatusViewController : UIViewController 
{
	UIButton *goBackButton;		// The button to go back to previous view.
	
	UILabel *nameField;			// Display player's name.
	UILabel *killsField;		// Display how many enemies player killed.
	UILabel *deathsField;		// Display how many time player died.
	UILabel *stageField;		// Display the current stage of the player.
	UILabel *timeField;			// Display how long the game has been played.
	UILabel *arenaField;		// Display the arena information.
	UILabel *rankField;			// Display the player's rank.
	
	UIImageView *airMedalImage;
	UIImageView *earthMedalImage;
	UIImageView *fireMedalImage;
	UIImageView *waterMedalImage;
}

@property (nonatomic, retain) IBOutlet UIButton *goBackButton;
@property (nonatomic, retain) IBOutlet UILabel *nameField;
@property (nonatomic, retain) IBOutlet UILabel *killsField;
@property (nonatomic, retain) IBOutlet UILabel *deathsField;
@property (nonatomic, retain) IBOutlet UILabel *stageField;
@property (nonatomic, retain) IBOutlet UILabel *timeField;
@property (nonatomic, retain) IBOutlet UILabel *arenaField;
@property (nonatomic, retain) IBOutlet UILabel *rankField;
@property (nonatomic, retain) IBOutlet UIImageView *airMedalImage;
@property (nonatomic, retain) IBOutlet UIImageView *earthMedalImage;
@property (nonatomic, retain) IBOutlet UIImageView *fireMedalImage;
@property (nonatomic, retain) IBOutlet UIImageView *waterMedalImage;

- (IBAction)switchViewToGoback:(id)sender;

@end
