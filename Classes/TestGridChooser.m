//
//  TestGridChooser.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestGridChooser.h"
#import "GridChooser.h"
#import "Grid.h"

@implementation TestGridChooser

-(void) testReadingFromFile {	
	GridChooser *gridChooser = [GridChooser shared];	
	for (int i = 0; i < 100; i++) {		
		Grid *grid = [[gridChooser pick] retain];		
		NSLog(@"grid is %@", grid);
	}	
}

@end
