//
//  Elemental_SymphonyGameOverViewController.h
//  Elemental_Symphony
//
//  Created by Tianyi Wang on 7/17/10.
//  Copyright 2010 University of Illinois at Urbana-Champaign. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Elemental_SymphonyGameOverViewController : UIViewController 
{
	UIButton *screenButton;
}

@property (nonatomic, retain) IBOutlet UIButton *screenButton;

- (IBAction)switchViewToMainView:(id)sender;

@end
