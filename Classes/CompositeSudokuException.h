//
//  CompositeSudokuException.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SudokuException.h"

@interface CompositeSudokuException : NSException {

	NSMutableArray *sudokuExceptions;
	
}

@property(nonatomic, copy) NSMutableArray *sudokuExceptions;

-(void) addSudokuException:(SudokuException *)se;
-(BOOL) isViolation;

@end
