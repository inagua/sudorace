//
//  GridView.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grid.h"

@interface GridView : UIView {
	Grid *grid;	
}

@property(nonatomic, retain) Grid *grid;

@end
