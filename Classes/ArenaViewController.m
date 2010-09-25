 //
//  ArenaViewController.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ArenaViewController.h"
#import "SudokuException.h"

@interface ArenaViewController(private)
-(void) updateProgress;
-(void) startClock ;
-(void) updateClock;
@end


@implementation ArenaViewController

@synthesize arena;
@synthesize grid;
@synthesize arenaView;
@synthesize gridView;
@synthesize transparentButton;
@synthesize clock;
@synthesize myProgressView;

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

	if (digit>9) {
		NSLog(@"will clear cell");
		return;
	}
	
	int currentX = transparentButton.currentX;
	int currentY = transparentButton.currentY;	
	NSLog(@"%@ %d %d", grid, currentX, currentY);
	
	@try {
		[grid fillX:currentX Y:currentY val:digit];		
		[gridView hideViolation];
		[gridView setNeedsDisplay];
		
		[self updateProgress];
	}
	@catch (CompositeSudokuException *cse) {		
		NSLog(@"Violating %@", cse);
		[gridView showViolation:cse];
	}
	@catch (NSException *e) {
		NSLog(@"DUH DUH DUH %@", e);
	}	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	arenaView.arena			= self.arena;
	gridView.grid			= self.grid;
	transparentButton.arena = self.arena;
	
	myProgressView.progress = 0.0;
	[self startClock];
	
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

#pragma mark private

-(void)updateProgress{	
	myProgressView.progress = [grid fillingPercent];	
}

-(void) startClock {
	
	startTime = [[NSDate date] timeIntervalSince1970];
	[self updateClock];
	clockUpdater = [NSTimer scheduledTimerWithTimeInterval:1 
													target:self
												  selector:@selector(updateClock)
												  userInfo:nil
												   repeats:YES];		
}

-(void) updateClock {
	double now = [[NSDate date] timeIntervalSince1970];
	
	int nbSeconds = (int)(now - startTime);		
	int nbHours = nbSeconds / 3600;	
	nbSeconds -= nbHours * 3600;	
	int nbMinutes = nbSeconds / 60;
	nbSeconds = nbSeconds - nbMinutes * 60.0;
	
	clock.text = [NSString stringWithFormat:@"%02d:%02d", nbMinutes, nbSeconds];
}

#pragma mark -

- (void)dealloc {
	[arena release];
	[arenaView release];	
	[gridView release];
	[grid release];

	[transparentButton release];
	[clock release];
	[myProgressView release];
	
    [super dealloc];
}


@end
