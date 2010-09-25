//
//  TransparentButton.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TransparentButton.h"

@interface TransparentButton(private)
- (void) recordCurrentCell: (NSSet *) touches;
@end

@implementation TransparentButton

@synthesize arena;
@synthesize currentX;
@synthesize currentY;

- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self=[super initWithCoder:aDecoder]) {
		currentX = -1;
	}
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{	
	[self recordCurrentCell: touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{	
	[self recordCurrentCell: touches];
}

- (void)drawRect:(CGRect)rect {
    
	if (currentX != -1) {
		
			// NSLog(@"drawing %d %d", currentX, currentY);
		
		CGContextRef ctx = UIGraphicsGetCurrentContext(); 
		CGContextSetLineWidth(ctx, 2.0);
		CGContextSetRGBStrokeColor(ctx, 0.4, 0.4, 0.4, 0.8); 
		
		CGFloat cellWidth = self.bounds.size.width / 9.0;
		CGFloat cellHeight = self.bounds.size.height / 9.0;		
		int x0 = cellWidth * currentX;
		int y0 = cellHeight * currentY;
		
		CGContextMoveToPoint(ctx, x0+2, y0+2);
		CGContextAddLineToPoint( ctx, x0+cellWidth-4, y0+2);		
		CGContextAddLineToPoint( ctx, x0+cellWidth-4, y0+cellHeight-4);		
		CGContextAddLineToPoint( ctx, x0+2, y0+cellHeight-4);		
		CGContextAddLineToPoint( ctx, x0+2, y0+2);		
		
		CGContextStrokePath(ctx);
	}	
}


#pragma mark private

- (void) recordCurrentCell: (NSSet *) touches  {
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
}


#pragma mark -

- (void)dealloc {
	[arena release];
    [super dealloc];
}


@end
