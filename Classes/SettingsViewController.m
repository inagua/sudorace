//
//  SettingsViewController.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "DashboardViewController.h"

@implementation SettingsViewController

@synthesize nameTextField;
@synthesize switcher;

-(IBAction)buttonPressed:(id)sender{
	
	NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
	[def setObject:nameTextField.text forKey:@"name"];
	
	DashboardViewController *db = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil];
	[self.navigationController pushViewController:db animated:YES];
	[db release];	
}

-(IBAction) toggleInfo{
	[switcher toggleInfo];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
	nameTextField.text = [def stringForKey:@"name"];
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
	[nameTextField release];
	[switcher release];
	
    [super dealloc];
}


@end
