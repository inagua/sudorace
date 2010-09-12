//
//  Player.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize name;

-(id) initWithName:(NSString *)playerName{
	
	if (self=[super init]) {		
		self.name = playerName;		
	}
	
	return self;
	
}

@end
