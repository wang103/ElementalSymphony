//
//  Elemental_SymphonyPrizeViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/23/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Elemental_SymphonyPrizeViewController : UIViewController 
{
	UIButton *continueButton;
	
	UIImageView *selectedImageView;
	UIImageView *firstPrizeView;
	UIImageView *secondPrizeView;
	
	int selection;			// 0: not selected; 1: prize 1; 2: prize 2.
}

@property (nonatomic, retain) IBOutlet UIButton *continueButton;
@property (nonatomic, retain) UIImageView *selectedImageView;
@property (nonatomic, retain) IBOutlet UIImageView *firstPrizeView;
@property (nonatomic, retain) IBOutlet UIImageView *secondPrizeView;

- (IBAction)continueButtonClicked:(id)sender;
- (void)applyChosenPrize;

@end
