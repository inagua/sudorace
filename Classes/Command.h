//
//  Command.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject {
	NSString *verb;
	NSString *params;
}

@property(nonatomic, retain) NSString *verb;
@property(nonatomic, retain) NSString *params;

@end
