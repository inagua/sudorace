    //
//  SwitchViewController.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SwitchViewController.h"


@implementation SwitchViewController

@synthesize dashboardViewController;
@synthesize settingsViewController;

-(void)toggleInfo {
	NSLog(@"will toggle info");
		
	[UIView beginAnimations:@"flip" context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	if (settingsViewController.view.superview == nil) {
		NSLog(@"displaying settingsViewController");
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
		[settingsViewController viewWillAppear:YES];
		[dashboardViewController viewDidDisappear:YES];
		[dashboardViewController.view removeFromSuperview];
		[self.view insertSubview:settingsViewController.view atIndex:0];
		[dashboardViewController viewDidDisappear:YES];
		[settingsViewController viewDidAppear:YES];		 
	}else {
		NSLog(@"displaying dashboard");
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
		[dashboardViewController viewWillAppear:YES];
		[settingsViewController viewDidDisappear:YES];
		[settingsViewController.view removeFromSuperview];
		[self.view insertSubview:dashboardViewController.view atIndex:0];
		[settingsViewController viewDidDisappear:YES];
		[dashboardViewController viewDidAppear:YES];	
	}
	
	[UIView commitAnimations];
}

-(id) init{	
	if(self=[super init]){		
		settingsViewController	= [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
		dashboardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil];	
		
		settingsViewController.switcher = self;
		dashboardViewController.switcher = self;
	}
	return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

//- (void)addInfoButton {	
//	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
//	[infoButton addTarget:self action:@selector(toggleInfo:) forControlEvents:UIControlEventTouchUpInside];	
//	
//	UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:infoButton];	
//	self.navigationItem.rightBarButtonItem = item;
//	
//	[infoButton release];
//	[item release];
//}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
	[self.view insertSubview:dashboardViewController.view atIndex:0];	
//	[self addInfoButton];
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
	[dashboardViewController release];
	[settingsViewController release];
    [super dealloc];
}


@end
