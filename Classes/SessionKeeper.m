//
//  SessionKeeper.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SessionKeeper.h"

static SessionKeeper *sharedInstance = nil;

@implementation SessionKeeper

@synthesize currentSession;

-(id) init {
	if (self=[super init]) {
		self.currentSession = [[GKSession alloc] initWithSessionID:nil displayName:nil sessionMode:GKSessionModePeer];
		self.currentSession.available = YES;
		self.currentSession.disconnectTimeout = 0;		
	}
	return self;
}

+(SessionKeeper *) shared {
	@synchronized(self){
        if (sharedInstance == nil){
			sharedInstance = [[SessionKeeper alloc] init];
		}
	}
	return sharedInstance;
}

-(void) dealloc {
	[currentSession release];
	[super dealloc];
}

@end
