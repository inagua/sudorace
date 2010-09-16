//
//  ArenaViewController.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ArenaViewController.h"


@implementation ArenaViewController

@synthesize arena;
@synthesize grid;
@synthesize arenaView;
@synthesize keyboard;
@synthesize transparentButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(IBAction)digitPressed:(id)sender{	
	UIButton *button = (UIButton *)sender;						
	int digit = [button.titleLabel.text characterAtIndex:0] - '0';	
	NSLog(@"digit is %d", digit);

	int currentX = transparentButton.currentX;
	int currentY = transparentButton.currentY;	
	NSLog(@"%@ %d %d", grid, currentX, currentY);
	
	@try {
		[grid fillX:currentX Y:currentY val:digit];
	}
	@catch (NSException * e) {
		NSLog(@"%@", e);
	}

	keyboard.hidden = YES;
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	arenaView.arena = self.arena;
	[super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[arena release];
	[arenaView release];	
	[grid release];
	[keyboard release];
	[transparentButton release];	
	
    [super dealloc];
}


@end
