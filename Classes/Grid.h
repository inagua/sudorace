//
//  Grid.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Grid : NSObject {
	
	NSMutableArray *fixedCellsIndexes;
	
	int cells[9][9];
	
	NSMutableArray *rows[9];
	NSMutableArray *cols[9];
	NSMutableArray *subs[9];
	
	Player *player;
}

@property(nonatomic, retain) Player *player;

-(id)initWithString:(NSString *)s;
-(void)fillX:(int)x Y:(int)y val:(int)val;
-(double)fillingPercent;

@end
