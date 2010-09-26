//
//  Grid.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Grid.h"
#import "SudokuException.h"
#import "CompositeSudokuException.h"

struct SPoint {
	int i;
	int j;
};
typedef struct SPoint SPoint;

@interface Grid (private)

-(void)checkLength:(NSString *)s;
- (void)checkNotFixedX:(int)x andY:(int)y;
- (void)checkSudokuRulesX:(int)x andY:(int)y val:(int)val;

-(void)fillFixedCells:(NSString *)s;
-(void)copyInitialString:s;

-(int)indexFromX:(int)x AndY:(int)y;
-(SPoint)fromIndex:(int)index;
-(int)subIndexFromX:(int)x AndY:(int)y;

-(int) computeNbCellsFilledByUser;
@end

@implementation Grid

@synthesize player;
@synthesize initialString;

-(id)initWithString:(NSString *)s{
		
	if (self=[super init]) {
		[self checkLength:s];
		[self fillFixedCells:s];
		[self copyInitialString:s];
	}
	return self;
}


-(void)fillX:(int)x Y:(int)y val:(int)val{	
	[self checkNotFixedX:x andY:y];	
	[self checkSudokuRulesX:x andY:y val:val];	
	cells[x][y] = val;
}

-(double)fillingPercent {	
	int nbCellsToFind = 81 - [fixedCellsIndexes count]; 	
	return (double)[self computeNbCellsFilledByUser] / (double)nbCellsToFind;
}

#pragma mark private methods

-(void)checkLength:(NSString *)s{
	int size = [s length];
	if (size != 81) {
		[NSException raise:NSInvalidArgumentException format:@"wrong size %d", size]; 
	}
}

-(int)valueAtX:(int)x Y:(int)y {
	return cells[x][y];
}

-(BOOL) isFilledX:(int)x andY:(int)y{
	return [self valueAtX:x Y:y] != 0;
}

-(BOOL) isFixedX:(int)x andY:(int)y  {
	int index = [self indexFromX:x AndY:y];	
	return [fixedCellsIndexes containsObject:[NSNumber numberWithInt:index]];	
}
	
- (void) checkNotFixedX:(int)x andY:(int)y  {	
	if ([self isFixedX:x andY:y]) {
		[NSException raise:NSInvalidArgumentException format:@"Attempt to fill fixed cell"]; 
	}
}

- (void)checkRow:(int)y DoesNotContain:(int)val except:(int)exceptX accu:(CompositeSudokuException *)accu{
	for (int x = 0; x < 9; x++) {
		if (x==exceptX) {
			continue;
		}
		if ([self valueAtX:x Y:y]==val) {
			[accu addSudokuException:[[SudokuException alloc] initWithType:RowException guilty:y atPlace:x]];
		}
	}
}

- (void)checkCol:(int)x DoesNotContain:(int)val except:(int)exceptY accu:(CompositeSudokuException *)accu{
	for (int y = 0; y < 9; y++) {
		if (y==exceptY) {
			continue;
		}
		if ([self valueAtX:x Y:y]==val) {
			[accu addSudokuException:[[SudokuException alloc] initWithType:ColException guilty:x atPlace:y]];
		}
	}
}

- (void)checkSub:(int)s DoesNotContain:(int)val exceptX:(int)exceptX andY:(int)exceptY accu:(CompositeSudokuException *)accu{
	
	int originSubX = s%3 *3;
	int originSubY = s/3 *3;
	
	for (int y = 0; y < 3; y++) {
		int checkY = originSubY + y;

		for (int x = 0; x < 3; x++) {			
			int checkX = originSubX + x;
			
			if (checkX==exceptX	&& checkY==exceptY) {
				continue;
			}
			
			if ([self valueAtX:checkX Y:checkY] == val) {
				int place = x + y*3;
				[accu addSudokuException:[[SudokuException alloc] initWithType:SubException guilty:s atPlace:place]];
			}
		}
	}
}


- (void)checkSudokuRulesX:(int)x andY:(int)y val:(int)val{
	if (val<0 || val>9) {
		[NSException raise:NSInvalidArgumentException format:@"wrong val %d", val]; 
	}

	CompositeSudokuException *allViolations = [[CompositeSudokuException alloc] init];
	
	[self checkRow:y DoesNotContain:val except:x accu:allViolations];	
	[self checkCol:x DoesNotContain:val except:y accu:allViolations];	
	int indexSub = [self subIndexFromX:x AndY:y];
	[self checkSub:indexSub DoesNotContain:val exceptX:x andY:y accu:allViolations];
	
	NSLog(@"allviolations %@", allViolations.sudokuExceptions);
	
	if ([allViolations isViolation]) {
		@throw allViolations;
	}	
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
		}
	}	
}

-(void)copyInitialString:s{
	self.initialString = s;
}

-(int) computeNbCellsFilledByUser {	
	int result = 0;	
	for (int j = 0; j < 9; j++) {
		for (int i = 0; i < 9; i++) {			
			if (![self isFixedX:i andY:j] && cells[i][j]!=0) {
				result ++;
			}
		}
	}
	return result;
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

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone{
	return [[Grid alloc] initWithString:self.initialString];
}

#pragma mark compare

- (NSComparisonResult)compare:(id)otherObject {
	
	double selfPercent = [self fillingPercent];
	double otherPercent = [(Grid *)otherObject fillingPercent];
	
	if (selfPercent > otherPercent) {
		return NSOrderedAscending;
	}else if (selfPercent < otherPercent) {
		return NSOrderedDescending;
	}else {
		return NSOrderedSame;
	}
	
}

#pragma mark -

-(void)dealloc{
	[player release];
	[initialString release];	
	
	[fixedCellsIndexes release];
	
	[super dealloc];
}

-(NSString *)description {	
	NSString *result = [NSString stringWithFormat:@"Creator : %@ \n", player.name];
	for (int j = 0; j < 9; j++) {
		for (int i = 0; i < 9; i++) {
			result = [result stringByAppendingFormat:@"%d ", cells[i][j] ];
		}
		result = [result stringByAppendingString:@"\n"];		
	}
	return result;
}

@end
