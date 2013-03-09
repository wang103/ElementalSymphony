//
//  Elemental_SymphonyGuideViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/2/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Elemental_SymphonyGuideViewController : UIViewController
{
	UILabel *pageLabel;
	UIButton *prevPageButton;
	UIButton *nextPageButton;
	UIImageView *contentImageView;
	UIButton *goBackButton;
	
	int currentPage;		// 1 ~ 13.
}

@property (nonatomic, retain) IBOutlet UILabel *pageLabel;
@property (nonatomic, retain) IBOutlet UIButton *prevPageButton;
@property (nonatomic, retain) IBOutlet UIButton *nextPageButton;
@property (nonatomic, retain) IBOutlet UIImageView *contentImageView;
@property (nonatomic, retain) IBOutlet UIButton *goBackButton;

- (IBAction)switchViewToGoback:(id)sender;
- (IBAction)goToNextPage:(id)sender;
- (IBAction)gotoPrevPage:(id)sender;
- (void)setContentAccordingToCurrentPage;

@end
