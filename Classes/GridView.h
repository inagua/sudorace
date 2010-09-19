//
//  GridView.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grid.h"
#import "SudokuException.h"
#import "CompositeSudokuException.h"

@interface GridView : UIView {
	Grid *grid;		
	
	CompositeSudokuException *currentViolations;
	NSTimer *violationHider;
}

@property(nonatomic, retain) Grid *grid;
@property(nonatomic, retain) NSTimer *violationHider;

-(void) showViolation:(CompositeSudokuException *)sudokuExceptions;
-(void) hideViolation;

@end
