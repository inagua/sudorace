//
//  GridView.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GridView.h"

@interface GridView(private)
	
-(void)drawFilledCells;
-(void)drawViolation;
- (float) cellWidth;
- (float) cellHeight;

@end


@implementation GridView

@synthesize grid;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	[self drawFilledCells];
	[self drawViolation];
}

-(void) showViolation:(SudokuException *)sudokuException{
	currentViolation = sudokuException;
}

#pragma mark private

-(void) drawColViolation{
	
	float cellWidth  = [self cellWidth];
	float cellHeight = [self cellHeight];
	float x0 = currentViolation.guiltyIndex * cellWidth;
	float y0 = 0;	
	
	CGContextRef ctx = UIGraphicsGetCurrentContext(); 
	CGContextSetLineWidth(ctx, 3.0);
	CGContextSetRGBStrokeColor(ctx, 0.8, 0.0, 0.0, 1);
	CGContextMoveToPoint(ctx, x0+2, y0+2);
	CGContextAddLineToPoint( ctx, x0+cellWidth-4, y0+2);		
	CGContextAddLineToPoint( ctx, x0+cellWidth-4, y0+9*cellHeight-4);		
	CGContextAddLineToPoint( ctx, x0+2, y0+9*cellHeight-4);		
	CGContextAddLineToPoint( ctx, x0+2, y0);		
	
	CGContextStrokePath(ctx);
	
}

-(void) drawRowViolation{
	
}

-(void) drawSubViolation{
	
}

-(void)drawViolation{
	
	if (!currentViolation) {
		return;
	}
	
	switch (currentViolation.exceptionType) {
		case ColException:
			[self drawColViolation];
			break;
		case RowException:
			[self drawRowViolation];			
			break;
		case SubException:
			[self drawSubViolation];						
			break;			
		default:
			break;
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


#pragma mark -

- (void)dealloc {
	[grid release];
    [super dealloc];
}


@end
