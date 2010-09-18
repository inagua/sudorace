//
//  TransparentButton.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Arena.h"

@interface TransparentButton : UIView {	
	int currentX;
	int currentY;
	
	Arena *arena;
}

@property(nonatomic, retain) Arena *arena;

@property int currentX;
@property int currentY;

@end
