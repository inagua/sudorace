//
//  Cell.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"


@implementation Cell

@synthesize isFixed;
@synthesize value;
@synthesize percentFilledByPlayers;

-(id)initWithFixed:(BOOL)f value:(int)v andPercentFilledByPlayers:(double)p{	
	if(self=[super init]){	
		self.isFixed				= f;
		self.value					= v;
		self.percentFilledByPlayers = p;
	}
	return self;
}

@end
