//
//  Elemental_SymphonyInfoViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/2/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Elemental_SymphonyInfoViewController : UIViewController 
{
	UIButton *prevPageButton;
	UIButton *nextPageButton;
	UIButton *goBackButton;
	UIImageView *skillView1;
	UIImageView *skillView2;
	UILabel *pageLabel;
	
	int currentPage;		// Total page will always be 9.
}

@property (nonatomic, retain) IBOutlet UIButton *prevPageButton;
@property (nonatomic, retain) IBOutlet UIButton *nextPageButton;
@property (nonatomic, retain) IBOutlet UIButton *goBackButton;
@property (nonatomic, retain) IBOutlet UIImageView *skillView1;
@property (nonatomic, retain) IBOutlet UIImageView *skillView2;
@property (nonatomic, retain) IBOutlet UILabel *pageLabel;

- (IBAction)switchViewToGoback:(id)sender;
- (IBAction)goToNextPage:(id)sender;
- (IBAction)gotoPrevPage:(id)sender;
- (void)setTwoCellsAccordingToCurrentPage;

@end
