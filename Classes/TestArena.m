//
//  TestArena.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestArena.h"
#import "Grid.h"

@implementation TestArena

-(void)setUp {
	joe = [[Player alloc] initWithName:@"joe"];	
	arena = [[Arena alloc] initWithPlayer:joe];
}

-(void)testAfterArenaCreationGridForJoeIsCreated {		
	NSArray *grids = [arena gridsOrderedByFilling];
	GHAssertEquals(1, (int)[grids count], @"");
	
	Grid *grid = [grids objectAtIndex:0];
	GHAssertEquals(grid.player, joe, @""); 	
}

-(void)testsWhenAcceptNewPlayer {	
	Player *jack = [[Player alloc] initWithName:@"jack"];
	Grid *jackGrid =[arena acceptPlayer:jack];	

	Grid *joeGrid = [[arena gridsOrderedByFilling] objectAtIndex:0];
	GHAssertEquals(jackGrid.player.name, @"jack", @"");
	
	[jackGrid fillX:6 Y:8 val:6];
	GHAssertEquals([joeGrid fillingPercent], 0.0, @"");
	GHAssertEquals([jackGrid fillingPercent], 1.0/3.0, @"");
	
	NSArray *grids = [arena gridsOrderedByFilling];
	GHAssertEquals(2, (int)[grids count], @"");
	GHAssertEqualObjects([grids objectAtIndex:0], jackGrid, @"");
}

-(void)assertCellAtX:(int)x Y:(int)y isFixed:(BOOL)f value:(int)value percent:(double)percent {
	Cell *cell = [arena cellAtX:x andY:y];
	GHAssertEquals(cell.isFixed, f, @"");
	GHAssertEquals(cell.percentFilledByPlayers, percent, @"");
	GHAssertEquals(cell.value, value, @"");
}

-(void)testsCellsAtInArena {

	[self assertCellAtX:0 Y:0 isFixed:YES value:2 percent:0.0];
	
	[self assertCellAtX:8 Y:8 isFixed:NO value:0 percent:0.0];
		
	Player *jack = [[Player alloc] initWithName:@"jack"];
	Grid *jackGrid =[arena acceptPlayer:jack];	
	[jackGrid fillX:8 Y:8 val:5];
	[self assertCellAtX:8 Y:8 isFixed:NO value:0 percent:1.0/2.0];

	// fill by joe
	[[[arena gridsOrderedByFilling] objectAtIndex:1] fillX:8 Y:8 val:5];	
	[self assertCellAtX:8 Y:8 isFixed:NO value:0 percent:1.0];	
}

@end
