//
//  TestArena.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestArena.h"
#import "Arena.h"
#import "Player.h"
#import "Grid.h"

@implementation TestArena

-(void)testCreationArena {	
	Player *joe = [[Player alloc] initWithName:@"joe"];	
	Arena *arena = [[Arena alloc] initWithPlayer:joe];
	
	NSArray *grids = [arena gridsOrderedByFilling];
	GHAssertEquals(1, (int)[grids count], @"");
	
	Grid *grid = [grids objectAtIndex:0];
	GHAssertEquals(grid.player, joe, @""); 	
}

-(void)testsWhenAcceptNewPlayer {	
	Player *joe = [[Player alloc] initWithName:@"joe"];	
	Player *jack = [[Player alloc] initWithName:@"jack"];
	
	Arena *arena = [[Arena alloc] initWithPlayer:joe];
	[arena acceptPlayer:jack];
	
	NSArray *grids = [arena gridsOrderedByFilling];
	GHAssertEquals(2, (int)[grids count], @"");
	
}

@end
