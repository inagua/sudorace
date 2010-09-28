//
//  SessionKeeper.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface SessionKeeper : NSObject {
	GKSession *currentSession;	
}

@property(nonatomic, retain) GKSession *currentSession;

+(SessionKeeper *)shared;

@end
