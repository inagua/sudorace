//
//  Interpret.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Interpret.h"

#define SEP @":"

static Interpret *sharedInstance = nil;

@implementation Interpret

+(Interpret *) shared {
	@synchronized(self){
        if (sharedInstance == nil){
			sharedInstance = [[Interpret alloc] init];
		}
	}
	return sharedInstance;
}

-(Command *)read:(NSString *)message{
	
	NSRange range = [message rangeOfString:SEP];
	int index = range.location;
	
	if (index==-1) {
		[NSException raise:@"Wrong message" format:@"Unable to read '%@'", message];
	}
	
	Command *result = [[Command alloc] init];
	result.verb = [message substringToIndex:index];
	result.params = [message substringFromIndex:index+1];
	
	return result;
}

@end
