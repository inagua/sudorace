//
//  SettingsViewController.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {

	IBOutlet UITextField *nameTextField;
	
}

@property(nonatomic, retain) UITextField *nameTextField;

-(IBAction)buttonPressed:(id)sender;

@end
