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


#pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)decoder{
	if (self=[super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{	
	[encoder encodeObject:self.name forKey:@"name"];
}

#pragma mark -
-(NSString *) description {
	return [NSString stringWithFormat:@"(player %@)", name];
}

-(BOOL)isEqual:(id)object{
	Player *other = (Player *)object;
	return [other.name isEqualToString:self.name];
}

@end
