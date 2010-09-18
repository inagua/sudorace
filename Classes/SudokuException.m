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
@synthesize place;

-(id) initWithType:(SudokuExceptionType)t guilty:(int)g atPlace:(int)p{
	
	if (self=[super initWithName:@"SudokuException" reason:@"Violating Rule" userInfo:nil]) {
		exceptionType	= t;
		guiltyIndex		= g;
		place			= p;
	}	
	return self;
}

-(NSString *)description {
		
	NSString *type = exceptionType==ColException ? @"col" : exceptionType==RowException ? @"row" : @"sub"; 
	
	return [NSString stringWithFormat:@"%@ %d at place %d", type, guiltyIndex, place];
}

@end
