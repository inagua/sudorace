//
//  TransparentButton.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TransparentButton.h"

@interface TransparentButton(private)

-(void)showKeyboard;

@end


@implementation TransparentButton

@synthesize keyboard;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	UITouch *touch = [touches anyObject];	
	float x = [touch locationInView:self].x;
	float y = [touch locationInView:self].y;
	
	int i = (int)( x * 9 / self.bounds.size.width );
	int j = (int)( y * 9 / self.bounds.size.height );
	
	NSLog(@"touch %d %d", i, j);	
	
	[self showKeyboard];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark private

-(void)showKeyboard{
	keyboard.hidden = NO;
}


#pragma mark -

- (void)dealloc {
	[keyboard release];
    [super dealloc];
}


@end
