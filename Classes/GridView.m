//
//  GridView.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GridView.h"


@implementation GridView

@synthesize grid;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

	NSLog(@"DRAWING GRID");
	
	float cellWidth = self.frame.size.width / 9.0;
	float cellHeight = self.frame.size.height / 9.0;
	
	for (int i = 0; i < 9; i++) {
		for (int j = 0; j < 9; j++) {
			
			NSString *text = @" ";
			
			if ([grid isFilledX:i andY:j]) {
				text = [NSString stringWithFormat:@"%d", [grid valueAtX:i Y:j]];
			}
			
			float x = i * cellWidth;
			float y = j * cellHeight;
			
			CGRect textRect = CGRectMake(x + 10.0, y, cellWidth, cellHeight);
			[text drawInRect:textRect
					withFont:[UIFont fontWithName:@"HelveticaNeue" size:28]
			   lineBreakMode:UILineBreakModeWordWrap
				   alignment:UIBaselineAdjustmentAlignBaselines];
		}
	}
}


- (void)dealloc {
	[grid release];
    [super dealloc];
}


@end
