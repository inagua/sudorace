//
//  GridView.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GridView.h"

#define TIME_SHOW_VIOLATION 2

@interface GridView(private)
	
-(void)drawFilledCells;
-(void)drawViolation;
- (float) cellWidth;
- (float) cellHeight;

@end


@implementation GridView

@synthesize grid;
@synthesize violationHider;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
		// TODO : shoudn't redraw all cells when called only for a violation show/hide
	[self drawFilledCells];
	[self drawViolation];
}

-(void) hideViolation {
	currentViolations = nil;	
	if (self.violationHider) {
		[self.violationHider invalidate];
	}
	[self setNeedsDisplay];
}

-(void) showViolation:(CompositeSudokuException *)sudokuExceptions{
	
	if (self.violationHider) {
		[self.violationHider invalidate];
	}
	self.violationHider = [NSTimer scheduledTimerWithTimeInterval:TIME_SHOW_VIOLATION 
													  target:self
													selector:@selector(hideViolation) 
													userInfo:nil
													 repeats:NO];
	currentViolations = sudokuExceptions;
	[self setNeedsDisplay];
}

#pragma mark private

- (void) drawLinesForRectX0:(float)x0  y0:(float)y0  width:(float)width height:(float) height  {
	CGContextRef ctx = UIGraphicsGetCurrentContext(); 
	CGContextSetLineWidth(ctx, 3.0);
	
	CGContextSetRGBStrokeColor(ctx, 0.8, 0.0, 0.0, 0.6);
	CGContextMoveToPoint(	 ctx, x0+2,				y0+2);
	CGContextAddLineToPoint( ctx, x0+width-4,		y0+2);		
	CGContextAddLineToPoint( ctx, x0+width-4,		y0+height-4);		
	CGContextAddLineToPoint( ctx, x0+2,				y0+height-4);		
	CGContextAddLineToPoint( ctx, x0+2,				y0);		
	CGContextStrokePath(ctx);
}

- (void) drawRectX0:(float)x0  y0:(float)y0  width:(float)width height:(float) height  {
	CGContextRef ctx = UIGraphicsGetCurrentContext(); 	
	CGContextSetRGBFillColor(ctx, 0.8, 0.0, 0.0, 0.6);	
	CGRect rect = CGRectMake(x0+3, y0+3, width-6, height-6);
	CGContextFillRect(ctx, rect);
	
	NSLog(@"drawing wrong cell");
}

-(void) drawColViolation:(SudokuException *)violation{	
	float cellWidth  = [self cellWidth];
	float cellHeight = [self cellHeight];
	
	float x0 = violation.guiltyIndex * cellWidth;
	float y0 = 0;
	float width = cellWidth;
	float height = 9*cellHeight;	
	[self drawLinesForRectX0:x0 y0:y0 width:width height:height];	
	
	y0 = violation.place * cellHeight;
	width = cellWidth;
	height = cellHeight;	
	[self drawRectX0:x0 y0:y0 width:width height:height];	
}

-(void) drawRowViolation:(SudokuException *)violation{
	float cellWidth  = [self cellWidth];
	float cellHeight = [self cellHeight];
	
	float x0 = 0;
	float y0 = violation.guiltyIndex * cellHeight;
	float width = 9*cellWidth;
	float height = cellHeight;	
	[self drawLinesForRectX0:x0 y0:y0 width:width height:height];		
	
	x0 = violation.place * cellWidth;
	width = cellWidth;
	height = cellHeight;	
	[self drawRectX0:x0 y0:y0 width:width height:height];	
}

-(void) drawSubViolation:(SudokuException *)violation{
	float cellWidth  = [self cellWidth];
	float cellHeight = [self cellHeight];
	
	float x0 = violation.guiltyIndex % 3 * (3*cellWidth);
	float y0 = violation.guiltyIndex / 3 * (3*cellHeight);	
	float width		= 3*cellWidth;
	float height	= 3*cellHeight;	
	[self drawLinesForRectX0:x0 y0:y0 width:width height:height];	
	
	float wrongCellX0 = x0 + violation.place % 3 * cellWidth;
	float wrongCellY0 = y0 + violation.place / 3 * cellWidth;
	width = cellWidth;
	height = cellHeight;	
	[self drawRectX0:wrongCellX0 y0:wrongCellY0 width:width height:height];	
}

-(void)drawViolation{
	
	if (!currentViolations) {
		return;
	}
	
	for (SudokuException *se in currentViolations.sudokuExceptions) {
		switch (se.exceptionType) {
			case ColException:
				[self drawColViolation:se];
				break;
			case RowException:
				[self drawRowViolation:se];			
				break;
			case SubException:
				[self drawSubViolation:se];						
				break;			
			default:
				break;
		} 
	}
}

- (float) cellWidth {
  return self.frame.size.width / 9.0;
}

- (float) cellHeight {
  return self.frame.size.height / 9.0;
}

-(void)drawFilledCells {
	NSLog(@"DRAWING GRID");	
	float cellWidth  = [self cellWidth];
	float cellHeight = [self cellHeight];
		
	[[UIColor grayColor] setFill];
	
	for (int i = 0; i < 9; i++) {
		for (int j = 0; j < 9; j++) {
			
			if ([grid isFixedX:i andY:j]){
				continue;
			}
			
			NSString *text = @" ";			
			if ([grid isFilledX:i andY:j]) {
				text = [NSString stringWithFormat:@"%d", [grid valueAtX:i Y:j]];
			}
			
			float x = i * cellWidth;
			float y = j * cellHeight;			
			CGRect textRect = CGRectMake(x + 10.0, y, cellWidth, cellHeight);
			[text drawInRect:textRect
					withFont:[UIFont fontWithName:@"Georgia" size:28]
			   lineBreakMode:UILineBreakModeWordWrap
				   alignment:UIBaselineAdjustmentAlignBaselines];
		}
	}

}


#pragma mark -

- (void)dealloc {
	[grid release];
	[violationHider release];
	[currentViolations release];
    [super dealloc];
}


@end
