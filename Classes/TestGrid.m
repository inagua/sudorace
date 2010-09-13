//
//  TestGrid.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestGrid.h"
#import "Grid.h"

@implementation TestGrid

-(void)setUp{
		// sol is 625 at the end
	grid = [[Grid alloc] initWithString:@"246185379317649852589732164623417598178596243495328716854261937762953481931874..."];	
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
	
		// value already in row		
	GHAssertThrows([grid fillX:6 Y:8 val:9], @"");	
		// value already in col		
	GHAssertThrows([grid fillX:6 Y:8 val:5], @"");		
}

-(void)testCanFillGridWithCorrectValues {	
	GHAssertEquals([grid fillingPercent], 0.0, @"");
	
	[grid fillX:6 Y:8 val:6];
	GHAssertEquals([grid fillingPercent], 1.0/3.0, @"");
	
	[grid fillX:7 Y:8 val:2];
	GHAssertEquals([grid fillingPercent], 2.0/3.0, @"");

	[grid fillX:8 Y:8 val:5];
	GHAssertEquals([grid fillingPercent], 1.0, @"");
}


@end
