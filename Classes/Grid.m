//
//  Grid.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Grid.h"

struct SPoint {
	int i;
	int j;
};
typedef struct SPoint SPoint;

@interface Grid (private)

-(void)allocArrays;
-(void)checkLength:(NSString *)s;
- (void)checkNotFixedX:(int)x andY:(int)y;
- (void)checkSudokuRulesX:(int)x andY:(int)y val:(int)val;

-(void)fillFixedCells:(NSString *)s;

-(int)indexFromX:(int)x AndY:(int)y;
-(SPoint)fromIndex:(int)index;
-(int)subIndexFromX:(int)x AndY:(int)y;

@end


@implementation Grid

-(id)initWithString:(NSString *)s{
	
	if (self=[super init]) {
		[self allocArrays];
		[self checkLength:s];
		[self fillFixedCells:s];
	}
	return self;
}


-(void)fillX:(int)x Y:(int)y val:(int)val{	
	[self checkNotFixedX:x andY:y];	
	[self checkSudokuRulesX:x andY:y val:val];
	
	cells[x][y] = val;
}

#pragma mark private methods

-(void)allocArrays{	
	for (int i = 0; i < 9; i++) {
		rows[i] = [NSMutableArray array];
		cols[i] = [NSMutableArray array];
		subs[i] = [NSMutableArray array];
	}	
}

-(void)checkLength:(NSString *)s{
	int size = [s length];
	if (size != 81) {
		[NSException raise:NSInvalidArgumentException format:@"wrong size %d", size]; 
	}
}

- (void) checkNotFixedX:(int)x andY:(int)y  {
	int index = [self indexFromX:x AndY:y];
	
	if ([fixedCellsIndexes containsObject:[NSNumber numberWithInt:index]]) {
		[NSException raise:NSInvalidArgumentException format:@"Attempt to fill fixed cell"]; 
	}
}

-(void)checkSets:(NSArray *)array name:(NSString *)name DoesNotContain:(int)val {
	if ([array containsObject:[NSNumber numberWithInt:val]]){
		[NSException raise:NSInvalidArgumentException format:@"%@ contains %d", name, val];
	}
}

- (void)checkSudokuRulesX:(int)x andY:(int)y val:(int)val{
	if (val<0 || val>9) {
		[NSException raise:NSInvalidArgumentException format:@"wrong val %d", val]; 
	}
	
	[self checkSets:rows[y] name:@"rows" DoesNotContain:val ];
	[self checkSets:cols[x] name:@"cols" DoesNotContain:val];
	int indexSub = [self subIndexFromX:x AndY:y];
	[self checkSets:subs[indexSub] name:@"subs" DoesNotContain:val];
}

-(void)fillFixedCells:(NSString *)s{
	
	fixedCellsIndexes = [[NSMutableArray alloc] init];	
	for (int i = 0; i < 81; i++) {
		unichar c = [s characterAtIndex:i];
		if (c!='.') {
			int value = c-'0';			
			
			[fixedCellsIndexes addObject:[NSNumber numberWithInt:i]];
			
			SPoint sp = [self fromIndex:i];
			int i = sp.i;
			int j = sp.j;
			
			cells[i][j] = value;
			
			NSNumber *valueNumber = [NSNumber numberWithInt:value];
			[rows[j] addObject:valueNumber]; 
			[cols[i] addObject:valueNumber]; 			
			int indexSub = [self subIndexFromX:i AndY:j];
			[subs[indexSub] addObject:valueNumber];
		}

	}	
}

-(SPoint)fromIndex:(int)index{
	SPoint spoint;
	spoint.i = index % 9;
	spoint.j = index / 9;
	
	return spoint;
}

-(int)indexFromX:(int)x AndY:(int)y{
	return x + y*9; 
}

-(int)subIndexFromX:(int)x AndY:(int)y{
	return (y/3)*3+ x / 3;
}

#pragma mark -

-(NSString *)description {	
	NSString *result = [NSString string];
	for (int j = 0; j < 9; j++) {
		for (int i = 0; i < 9; i++) {
			result = [result stringByAppendingFormat:@"%d ", cells[i][j] ];
		}
		result = [result stringByAppendingString:@"\n"];		
	}
	return result;
}

@end
