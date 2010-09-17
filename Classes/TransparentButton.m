//
//  TransparentButton.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TransparentButton.h"

#define TIMEOUT_HIDE_KEYBOARD 2

@interface TransparentButton(private)
-(void)showKeyboard;
- (void) recordCurrentCell: (NSSet *) touches;
@end

@implementation TransparentButton

@synthesize keyboard;
@synthesize keyboardHider;

@synthesize currentX;
@synthesize currentY;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{	
	[self recordCurrentCell: touches];
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
	
	if (!keyboardHider || ![keyboardHider isValid]) {
		NSLog(@">>>>");
		if(keyboardHider){
			NSLog(@"AFTER first time");
			[keyboardHider invalidate];
		}else {
			NSLog(@"first time");
		}
		
		self.keyboardHider = [NSTimer scheduledTimerWithTimeInterval:TIMEOUT_HIDE_KEYBOARD 
														 target:self
													   selector:@selector(hideKeyboard)
													   userInfo:nil
														repeats:NO];
	}
}

-(void)hideKeyboard{
	[keyboardHider invalidate];
	keyboard.hidden = YES;
}

- (void) recordCurrentCell: (NSSet *) touches  {
	UITouch *touch = [touches anyObject];	
	float x = [touch locationInView:self].x;
	float y = [touch locationInView:self].y;
	
	currentX = (int)( x * 9 / self.bounds.size.width );
	currentY = (int)( y * 9 / self.bounds.size.height );	
	NSLog(@"touch %d %d", currentX, currentY);	
}

#pragma mark -

- (void)dealloc {
	[keyboard release];
    [super dealloc];
}


@end
