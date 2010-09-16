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
	IBOutlet ArenaView *arenaView;
}

@property(nonatomic, retain) Arena *arena;
@property(nonatomic, retain) ArenaView *arenaView;

@end
