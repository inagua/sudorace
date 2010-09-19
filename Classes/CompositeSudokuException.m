//
//  CompositeSudokuException.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CompositeSudokuException.h"

@implementation CompositeSudokuException

@synthesize sudokuExceptions;

-(id)init {
	if ( self=[super initWithName:@"CompositeSudokuException" reason:@"Violating Rules" userInfo:nil] ){
		sudokuExceptions = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void) addSudokuException:(SudokuException *)se{
	[sudokuExceptions addObject:se];
}

-(BOOL) isViolation{
	return [sudokuExceptions count]>0;
}

-(void)dealloc {
	[sudokuExceptions release];
	[super dealloc];
}

@end
