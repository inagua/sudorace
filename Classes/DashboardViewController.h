//
//  DashboardViewController.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface DashboardViewController : UIViewController <GKSessionDelegate> {

	GKSession *currentSession;

	IBOutlet UILabel *namesAround;
	IBOutlet UIView *arenasView;
}

@property (nonatomic, retain) GKSession *currentSession;
@property (nonatomic, retain) UILabel *namesAround;
@property (nonatomic, retain) UIView *arenasView;

-(IBAction) createArena;

@end
