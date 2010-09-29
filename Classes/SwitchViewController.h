//
//  SwitchViewController.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardViewController.h"
#import "SettingsViewController.h"

@interface SwitchViewController : UIViewController {

	DashboardViewController *dashboardViewController;
	SettingsViewController *settingsViewController;
}

@property(nonatomic, retain) DashboardViewController *dashboardViewController;
@property(nonatomic, retain) SettingsViewController *settingsViewController;

-(void)toggleInfo;

@end
