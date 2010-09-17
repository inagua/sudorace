//
//  TransparentButton.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TransparentButton : UIView {
	IBOutlet UIView *keyboard;
	
	int currentX;
	int currentY;
	
	NSTimer *keyboardHider;
}

@property(nonatomic, retain) UIView *keyboard;
@property(nonatomic, retain) NSTimer *keyboardHider;
@property int currentX;
@property int currentY;

@end