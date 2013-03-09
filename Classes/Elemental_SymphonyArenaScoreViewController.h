//
//  Elemental_SymphonyArenaScoreViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/6/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Elemental_SymphonyArenaScoreViewController : UIViewController
{
	UILabel *killsLabel;
	UILabel *recruitsLabel;
	UILabel *magicSpellsLabel;
	UILabel *goldLabel;
	UILabel *pointLabel;
	UIButton *continueButton;
	
	int kills;
	int recruits;
	int magic;
	int gold;
}

@property int kills;
@property int recruits;
@property int magic;
@property int gold;

@property (nonatomic, retain) IBOutlet UILabel *killsLabel;
@property (nonatomic, retain) IBOutlet UILabel *recruitsLabel;
@property (nonatomic, retain) IBOutlet UILabel *magicSpellsLabel;
@property (nonatomic, retain) IBOutlet UILabel *goldLabel;
@property (nonatomic, retain) IBOutlet UILabel *pointLabel;
@property (nonatomic, retain) IBOutlet UIButton *continueButton;

- (IBAction)continueButtonClicked:(id)sender;

@end
