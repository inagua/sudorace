//
//  TestGrid.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestGrid.h"
#import "Grid.h"
#import "SudokuException.h"
#import "CompositeSudokuException.h"

@implementation TestGrid

-(void)setUp{
		// sol is 625 at the end
	grid = [[Grid alloc] initWithString:@"246185379317649852589732164623417598178596243495328716854261937762953481.31874..."];	
}

-(void)testValueAt {
	GHAssertEquals([grid valueAtX:1 Y:0], 4, @"");
	GHAssertEquals([grid valueAtX:0 Y:1], 3, @"");
}

-(void)testInitGridWithStringChecksArgLength {	
	@try {
		[[Grid alloc] initWithString:@"123"];
		GHFail(@"shouldn't arrive here");
	}
	@catch (NSException * e) {
		GHAssertEqualStrings([e name], @"NSInvalidArgumentException", @"");
	}
}

-(void)testInitGridWithStringChecksWhenFilling {	
		//	attempt to fill a fixed cell 
	GHAssertThrows([grid fillX:5 Y:8 val:4], @"");
		// value out of range
	GHAssertThrows([grid fillX:6 Y:8 val:10], @"");
			
	@try {
		[grid fillX:6 Y:8 val:3];
		GHFail(@"shouldn't arrive here");
	}
	@catch (CompositeSudokuException *cse) {
		
		GHAssertEquals((int)[[cse sudokuExceptions] count], 3, @"");
		
		SudokuException *se = [[cse sudokuExceptions] objectAtIndex:0];
		GHAssertEquals(se.exceptionType, RowException, @"");
		GHAssertEquals(se.guiltyIndex, 8, @"");
		GHAssertEquals(se.place, 1, @"");
		
		se = [[cse sudokuExceptions] objectAtIndex:1];
		GHAssertEquals(se.exceptionType, ColException, @"");
		
		se = [[cse sudokuExceptions] objectAtIndex:2];
		GHAssertEquals(se.exceptionType, SubException, @"");
	}
}

-(void)testCanFillGridWithCorrectValues {	
	GHAssertEquals([grid fillingPercent], 0.0, @"");
	
	[grid fillX:6 Y:8 val:6];
	GHAssertEquals([grid fillingPercent], 1.0/4.0, @"");
	
	[grid fillX:7 Y:8 val:2];
	GHAssertEquals([grid fillingPercent], 2.0/4.0, @"");

	[grid fillX:8 Y:8 val:5];
	GHAssertEquals([grid fillingPercent], 3.0/4.0, @"");
	
	[grid fillX:0 Y:8 val:9];
	GHAssertEquals([grid fillingPercent], 4.0/4.0, @"");
}

-(void)testSerialization {

	Player *joe = [[Player alloc] initWithName:@"joe"];
	grid.player = joe;
	
	NSData *gridData = [NSKeyedArchiver archivedDataWithRootObject:grid];
	NSLog(@"gridData %@", gridData);

	Grid *deserialized = [NSKeyedUnarchiver unarchiveObjectWithData:gridData];
	NSLog(@"deserialized %@", deserialized);

	GHAssertEqualObjects(deserialized, grid, @"");
}


@end
