//
//  SettingsViewController.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchViewController;

@interface SettingsViewController : UIViewController {

	IBOutlet UITextField *nameTextField;
	SwitchViewController *switcher;
}

@property(nonatomic, retain) UITextField *nameTextField;
@property(nonatomic, retain) SwitchViewController *switcher;

-(IBAction) buttonPressed:(id)sender;
-(IBAction) toggleInfo;

@end
