//
//  GridChooser.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GridChooser.h"

@implementation GridChooser

@synthesize allGrids;	

static GridChooser *sharedInstance = nil;

-(id) initWithFileContent {
	if (self = [super init]) {
		
		NSLog(@"will read");
		
		self.allGrids = [[NSMutableArray alloc] init];
		
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"grids" ofType:@"txt"];		
		NSString *fh = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:NULL];				

		for (NSString *line in [fh componentsSeparatedByString:@"\n"]) {		
			[allGrids addObject:[[Grid alloc] initWithString:line]];			
		}
				
		NSLog(@"Reading done");
	}
	return self;
}

+(GridChooser *) shared {
	@synchronized(self){
        if (sharedInstance == nil){
			sharedInstance = [[GridChooser alloc] initWithFileContent];
		}
	}
	return sharedInstance;
}


-(Grid *) pick {	
	int gridIndex = arc4random() % [allGrids count];	
	return [allGrids objectAtIndex:gridIndex];
}

-(void) dealloc {
	[allGrids release];
	[super dealloc];
}

@end
