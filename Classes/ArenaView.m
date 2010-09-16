//
//  ArenaView.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ArenaView.h"
#import "Cell.h"

@implementation ArenaView

@synthesize arena;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	
	NSLog(@"should display %@", arena);	
	float cellWidth = self.frame.size.width / 9.0;
	float cellHeight = self.frame.size.height / 9.0;
	
	for (int i = 0; i < 9; i++) {
		for (int j = 0; j < 9; j++) {
			
			Cell *cell = [arena cellAtX:i andY:j];
			
			if ([cell isFixed]) {
				
				float x = i * cellWidth;
				float y = j * cellHeight;
				
				CGRect textRect = CGRectMake(x + 10.0, y, cellWidth, cellHeight);
				
				NSString *text = [NSString stringWithFormat:@"%d", [cell value]];				
				[text drawInRect:textRect
						withFont:[UIFont fontWithName:@"HelveticaNeue" size:28]
				   lineBreakMode:UILineBreakModeWordWrap
					   alignment:UIBaselineAdjustmentAlignBaselines];
			}
		}
	}
		
}


- (void)dealloc {
	[arena release];
	
    [super dealloc];
}


@end
