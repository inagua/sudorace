//
//  Grid.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Grid : NSObject <NSCopying, NSCoding> {
	
	NSString *initialString;
	
	int cells[9][9];	
	NSMutableArray *fixedCellsIndexes;
	
	Player *player;
}

@property(nonatomic, retain) Player *player;
@property(nonatomic, retain) NSString *initialString;

-(id)initWithString:(NSString *)s;
-(void)fillX:(int)x Y:(int)y val:(int)val;
-(double)fillingPercent;

-(BOOL) isFixedX:(int)x andY:(int)y;
-(BOOL) isFilledX:(int)x andY:(int)y;
-(int) valueAtX:(int)x Y:(int)y;

@end
