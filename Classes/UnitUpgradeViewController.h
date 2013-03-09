//
//  UnitUpgradeViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 12/17/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitUpgradeViewController : UIViewController 
{
	UILabel *samariumRockLabel;		// The label indicates the number of samarium stones.
	UIButton *previousPageButton;	// The button to flip to the previous page.
	UIButton *nextPageButton;		// The button to flip to the next page.
	
	UIImageView *firstSkillView;
	UIImageView *secondSkillView;
	UIImageView *thirdSkillView;
	UIButton *firstButton;
	UIButton *secondButton;
	UIButton *thirdButton;
	
	UILabel *first0Label;
	UILabel *first1Label;
	UILabel *first2Label;
	UILabel *first3Label;
	UILabel *first4Label;
	UILabel *first5Label;
	UILabel *second0Label;
	UILabel *second1Label;
	UILabel *second2Label;
	UILabel *second3Label;
	UILabel *second4Label;
	UILabel *second5Label;
	UILabel *third0Label;
	UILabel *third1Label;
	UILabel *third2Label;
	UILabel *third3Label;
	UILabel *third4Label;
	UILabel *third5Label;
	
	UIImageView *skillImageView1;
	UIImageView *skillImageView2;
	UIImageView *skillImageView3;
	UIImageView *skillImageView4;
	UIImageView *skillImageView5;
	UIImageView *skillImageView6;
	
	UIImageView *draggingImageView;
	
	UILabel *pageLabel;				// The label displays the page number.
	UIButton *goBackButton;			// The button to go back to the map.
	
	int currentPage;				// The current page number (start with 0) of the skills list.
	int totalPageNumber;			// The total number of pages of skill list.

	int currentlySelectedSkill;		// The skill clicked.
	CGRect skillsGrids[2][3];		// The rect for 6 using skills.
	
	NSMutableArray *availableSkills;	// All available skills.
	
	BOOL modified;
}

@property (nonatomic, retain) IBOutlet UILabel *samariumRockLabel;
@property (nonatomic, retain) IBOutlet UIButton *previousPageButton;
@property (nonatomic, retain) IBOutlet UIButton *nextPageButton;
@property (nonatomic, retain) IBOutlet UIImageView *firstSkillView;
@property (nonatomic, retain) IBOutlet UIImageView *secondSkillView;
@property (nonatomic, retain) IBOutlet UIImageView *thirdSkillView;
@property (nonatomic, retain) IBOutlet UIButton *firstButton;
@property (nonatomic, retain) IBOutlet UIButton *secondButton;
@property (nonatomic, retain) IBOutlet UIButton *thirdButton;
@property (nonatomic, retain) IBOutlet UILabel *first0Label, *first1Label, *first2Label, *first3Label, *first4Label, *first5Label;
@property (nonatomic, retain) IBOutlet UILabel *second0Label, *second1Label, *second2Label, *second3Label, *second4Label, *second5Label;
@property (nonatomic, retain) IBOutlet UILabel *third0Label, *third1Label, *third2Label, *third3Label, *third4Label, *third5Label;
@property (nonatomic, retain) IBOutlet UIImageView *skillImageView1, *skillImageView2, *skillImageView3;
@property (nonatomic, retain) IBOutlet UIImageView *skillImageView4, *skillImageView5, *skillImageView6;
@property (nonatomic, retain) IBOutlet UILabel *pageLabel;
@property (nonatomic, retain) IBOutlet UIButton *goBackButton;

- (IBAction)switchViewToGoback:(id)sender;
- (IBAction)goToNextPage:(id)sender;
- (IBAction)gotoPrevPage:(id)sender;

- (int)setThreeCellsAccordingToCurrentPage;
- (void)setSixUsingSkills;

- (void)hideSecondCell;
- (void)showSecondCell;
- (void)hideThirdCell;
- (void)showThirdCell;

- (void)initializeGrids;
- (UIImageView *)pointInsideSkillGrids:(CGPoint)point;

- (IBAction)upgradeSkill:(id)sender;
- (void)displayAttributes:(int)cellNumber :(int)skillNumber;
- (void)changeLabelsAfterUpgrade:(int)cell :(int)skillNumber :(int)level;

@end
