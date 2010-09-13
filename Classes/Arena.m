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
	if (self=[super init]) {					
		
		self.originalGrid = [self chooseGrid];
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

#pragma mark private
-(Grid *) chooseGrid {	
	Grid *result = [[Grid alloc] initWithString:@"246185379317649852589732164623417598178596243495328716854261937762953481931874..."];
	return result;
}


@end
