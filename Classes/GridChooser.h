//
//  GridChooser.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grid.h"

@interface GridChooser : NSObject {
	NSMutableArray *allGrids;	
} 

@property(nonatomic, retain) NSMutableArray *allGrids;	

+(GridChooser *)shared;
-(Grid *) pick;

@end
