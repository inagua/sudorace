//
//  Command.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Command.h"


@implementation Command

@synthesize verb;
@synthesize params;

-(void) dealloc {
	[verb release];
	[params release];
	[super dealloc];
}

@end
