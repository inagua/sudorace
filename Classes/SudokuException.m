//
//  SudokuException.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SudokuException.h"

@implementation SudokuException

@synthesize guiltyIndex;
@synthesize exceptionType;

-(id) initWithType:(SudokuExceptionType)t guilty:(int)g{
	
	if (self=[super initWithName:@"SudokuException" reason:@"Violating Rule" userInfo:nil]) {
		exceptionType	= t;
		guiltyIndex		= g;
	}
	
	return self;
}

@end
