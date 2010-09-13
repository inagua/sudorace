//
//  Arena.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Grid.h"
#import "Cell.h"

@interface Arena : NSObject {
	Grid *originalGrid;
	NSMutableArray *grids;
}

@property(nonatomic, retain) Grid *originalGrid;

-(id)initWithPlayer:(Player *)creator;
-(Grid *)acceptPlayer:(Player *)newPlayer;

-(NSArray *)gridsOrderedByFilling;

-(Cell *)cellAtX:(int)x andY:(int)y;

@end
