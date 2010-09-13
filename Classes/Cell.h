//
//  Cell.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Cell : NSObject {

	BOOL isFixed;
	int value;
	double percentFilledByPlayers;
}

@property BOOL isFixed;
@property int value;
@property double percentFilledByPlayers;

-(id)initWithFixed:(BOOL)f value:(int)v andPercentFilledByPlayers:(double)p;

@end
