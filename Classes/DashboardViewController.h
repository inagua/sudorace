//
//  DashboardViewController.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@class SwitchViewController;

@interface DashboardViewController : UIViewController <GKSessionDelegate> {

	GKSession *currentSession;
	
	NSMutableArray *arenasToJoinButtons;	
	
	IBOutlet UILabel *namesAround;
	IBOutlet UIView *arenasView;
	
	SwitchViewController *switcher;
}

@property (nonatomic, retain) GKSession *currentSession;
@property (nonatomic, retain) UILabel *namesAround;
@property (nonatomic, retain) UIView *arenasView;
@property (nonatomic, retain) SwitchViewController *switcher;;
@property (nonatomic, retain) NSMutableArray *arenasToJoinButtons;	

-(IBAction) createArena;
-(IBAction) showArena;

-(IBAction) toggleInfo;

@end
