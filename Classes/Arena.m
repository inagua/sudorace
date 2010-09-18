//
//  Arena.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Arena.h"
#import "Grid.h"

@interface Arena (private) 
-(Grid *) chooseGrid;
@end

@implementation Arena

@synthesize originalGrid;

-(id)initWithPlayer:(Player *)creator{	
	return [self initWithPlayer:creator grid:[self chooseGrid]];
}

-(id)initWithPlayer:(Player *)creator grid:(Grid *)grid{
	
	if (self=[super init]) {					
		self.originalGrid = grid;
		self.originalGrid.player = creator;
		
		grids = [[NSMutableArray alloc] init];
		[grids addObject:self.originalGrid];
		
	}
	return self;
}

-(Grid *)acceptPlayer:(Player *)newPlayer{
	
	Grid *newGrid = [originalGrid copy];
	newGrid.player = newPlayer;
	
	[grids addObject:newGrid];	
	return newGrid;
}

-(NSArray *)gridsOrderedByFilling{
	return [grids sortedArrayUsingSelector:@selector(compare:)];
}

-(double) computePercentFilledByUserAtX:(int)x andY:(int)y{
	
	int nbPlayers = [grids count];
	int nbPlayersThatFilled = 0;
	
	for (Grid *grid in grids) {
		if ([grid isFilledX:x andY:y]) {
			nbPlayersThatFilled++;
		}
	}
	
	return (double)nbPlayersThatFilled / (double)nbPlayers;
}

-(Cell *)cellAtX:(int)x andY:(int)y {
	
	if ([originalGrid isFixedX:x andY:y]) {
		int fixedValue = [originalGrid valueAtX:x Y:y];
		return [[Cell alloc] initWithFixed:YES value:fixedValue andPercentFilledByPlayers:0];
	}else {		
		double percent = [self computePercentFilledByUserAtX:x andY:y];		
		return [[Cell alloc] initWithFixed:NO value:0 andPercentFilledByPlayers:percent];
	}

}

#pragma mark private
-(Grid *) chooseGrid {	
		// TODO : choose grid randomly according to difficulty 
	Grid *result = [[Grid alloc] initWithString:@"...185379.1764985.58.73.1646.341..9817859.24.49.32.7168..261937762953481931874..."];
	return result;
}


@end
