//
//  TestInterpret.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestInterpret.h"
#import "Interpret.h"
#import "Command.h"

@implementation TestInterpret

-(void)testBuildCommandFromMessage {
	
	Command *actual = [[Interpret shared] read:@"play:flute:piano"];
	
	GHAssertEqualStrings(actual.verb, @"play", @"");
	GHAssertEqualStrings(actual.params, @"flute:piano", @"");	
}

@end
