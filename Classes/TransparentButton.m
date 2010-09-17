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
- (void) showKeyboard;
- (BOOL) recordCurrentCell: (NSSet *) touches;
@end

@implementation TransparentButton

@synthesize arena;
@synthesize keyboard;
@synthesize keyboardHider;

@synthesize currentX;
@synthesize currentY;

- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self=[super initWithCoder:aDecoder]) {
		currentX = -1;
	}
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{	
	if ([self recordCurrentCell: touches]){
		
		UITouch *touch = [touches anyObject];
		if ([touch tapCount]>1) {
			[self showKeyboard];
		}
	}
}

- (void)drawRect:(CGRect)rect {
    
	if (currentX != -1) {
		
		NSLog(@"drawing %d %d", currentX, currentY);
		
		CGContextRef ctx = UIGraphicsGetCurrentContext(); 
		CGContextSetLineWidth(ctx, 3.0);
		CGContextSetRGBStrokeColor(ctx, 0.4, 0.4, 0.4, 1); 
		
		CGFloat cellWidth = self.bounds.size.width / 9.0;
		CGFloat cellHeight = self.bounds.size.height / 9.0;		
		int x0 = cellWidth * currentX;
		int y0 = cellHeight * currentY;
		
		CGContextMoveToPoint(ctx, x0+2, y0+2);
		CGContextAddLineToPoint( ctx, x0+cellWidth-4, y0+2);		
		CGContextAddLineToPoint( ctx, x0+cellWidth-4, y0+cellHeight-4);		
		CGContextAddLineToPoint( ctx, x0+2, y0+cellHeight-4);		
		CGContextAddLineToPoint( ctx, x0+2, y0);		
		
		CGContextStrokePath(ctx);
	}	
}


#pragma mark private

-(void)showKeyboard{
	keyboard.hidden = NO;	
	
	if (!keyboardHider || ![keyboardHider isValid]) {		
		if(keyboardHider){
			[keyboardHider invalidate];
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


- (BOOL) recordCurrentCell: (NSSet *) touches  {
	UITouch *touch = [touches anyObject];
	float xTouch = [touch locationInView:self].x;
	float yTouch = [touch locationInView:self].y;
	
	int x = (int)( xTouch * 9 / self.bounds.size.width );
	int y = (int)( yTouch * 9 / self.bounds.size.height );	
	
	BOOL isFree = ![[arena cellAtX:x andY:y] isFixed];	
	if (isFree) {
		currentX = x;
		currentY = y;
		[self setNeedsDisplay];
	}
	
	return isFree;
}


#pragma mark -

- (void)dealloc {
	[arena release];
	[keyboardHider release];
	[keyboard release];
    [super dealloc];
}


@end
