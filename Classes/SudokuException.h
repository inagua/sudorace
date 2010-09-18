//
//  SudokuException.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ColException = 0,           
    RowException,          
	SubException
} SudokuExceptionType;

@interface SudokuException : NSException {
	int guiltyIndex;	
	int place;
	int exceptionType;
}

@property int guiltyIndex;
@property int exceptionType;
@property int place;

-(id) initWithType:(SudokuExceptionType)t guilty:(int)g atPlace:(int)p;

@end
