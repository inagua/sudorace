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

-(void)testInitGridWithStringChecksArgLength {	
	@try {
		[[Grid alloc] initWithString:@"123"];
		GHFail(@"shouldn't arrive here");
	}
	@catch (NSException * e) {
		GHAssertEqualStrings([e name], @"NSInvalidArgumentException", @"");
	}

	[[Grid alloc] initWithString:@"246185379317649852589732164623417598178596243495328716854261937762953481931874..."];
}

-(void)testInitGridWithString {
	
		// sol is 625 at the end
	Grid *grid = [[Grid alloc] initWithString:@"246185379317649852589732164623417598178596243495328716854261937762953481931874..."];	

	NSLog(@"grid is \n%@", grid);
	
		//	attempt to fill a fixed cell 
	GHAssertThrows([grid fillX:5 Y:8 val:4], @"");
	[grid fillX:6 Y:8 val:6];
	[grid fillX:7 Y:8 val:2];
	[grid fillX:8 Y:8 val:5];
	
		// value out of range
	GHAssertThrows([grid fillX:6 Y:8 val:10], @"");	
	
		// value already in row		
	GHAssertThrows([grid fillX:6 Y:8 val:9], @"");	
		// value already in col		
	GHAssertThrows([grid fillX:6 Y:8 val:5], @"");	
	
}

@end