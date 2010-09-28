//
//  TestPlayer.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestPlayer.h"
#import "Player.h"

@implementation TestPlayer

-(void)testSerialization{
	
	Player *joe = [[Player alloc] initWithName:@"joe"];
	
	NSData *playerData = [NSKeyedArchiver archivedDataWithRootObject:joe];
	NSLog(@"playerData %@", playerData);
	
	Player *deserialized = [NSKeyedUnarchiver unarchiveObjectWithData:playerData];
	NSLog(@"deserialized %@", deserialized);

	GHAssertEqualObjects(deserialized, joe, @"");
}

@end
