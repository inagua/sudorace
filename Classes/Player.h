//
//  Player.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject {
	NSString *name;
}

@property(nonatomic, retain) NSString *name;

-(id) initWithName:(NSString *)name;

@end
