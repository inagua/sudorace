//
//  ArenaView.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Arena.h"

@interface ArenaView : UIView {

	Arena *arena;
	
}

@property(nonatomic, retain) Arena *arena;

@end
