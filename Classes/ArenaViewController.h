//
//  ArenaViewController.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Arena.h"
#import "ArenaView.h"

@interface ArenaViewController : UIViewController {
	
	Arena *arena;
	Grid *grid;
	
	IBOutlet ArenaView *arenaView;
	IBOutlet UIView *keyboard;
}

@property(nonatomic, retain) Arena *arena;
@property(nonatomic, retain) Grid *grid;
@property(nonatomic, retain) ArenaView *arenaView;
@property(nonatomic, retain) UIView *keyboard;

-(IBAction)digitPressed:(id)sender;


@end
