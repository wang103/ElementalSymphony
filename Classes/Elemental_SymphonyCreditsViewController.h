//
//  Elemental_SymphonyCreditsViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 1/1/11.
//  Copyright 2011 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Elemental_SymphonyCreditsViewController : UIViewController
{
	UIButton *goBackButton;
}

@property (nonatomic, retain) IBOutlet UIButton *goBackButton;

- (IBAction)switchViewToGoback:(id)sender;

@end
