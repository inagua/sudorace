//
//  DashboardViewController.m
//  sudorace
//
//  Created by Stéphane Tavera on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DashboardViewController.h"
#import "ArenaViewController.h"
#import "Player.h"
#import "Arena.h"

@implementation DashboardViewController

@synthesize currentSession;
@synthesize txtMessage;
@synthesize connect;
@synthesize disconnect;

-(IBAction) createArena{
		
	Player *me = [[Player alloc] initWithName:@"Joe"];
	Arena *arena = [[Arena alloc] initWithPlayer:me];
	Grid *grid = [[arena gridsOrderedByFilling] objectAtIndex:0];
	
	ArenaViewController *arenaController = [[ArenaViewController alloc] initWithNibName:@"ArenaViewController" bundle:nil];
	arenaController.arena = arena;	
	arenaController.grid = grid;	
	
	[self.navigationController pushViewController:arenaController animated:YES];
	[arenaController release];
	
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
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	NSData* data;
    NSString *str = [NSString stringWithString:txtMessage.text];
    data = [str dataUsingEncoding: NSASCIIStringEncoding];        
    [self mySendDataToPeers:data];   
	
	[txtMessage resignFirstResponder];
}

- (void)peerPickerController:(GKPeerPickerController *)picker 
              didConnectPeer:(NSString *)peerID 
                   toSession:(GKSession *) session {
    self.currentSession = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
	picker.delegate = nil;
	
    [picker dismiss];
    [picker autorelease];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
    picker.delegate = nil;
    [picker autorelease];
    
    [connect setHidden:NO];
    [disconnect setHidden:YES];
}

- (void) mySendDataToPeers:(NSData *) data{
    if (currentSession) 
        [self.currentSession sendDataToAllPeers:data 
                                   withDataMode:GKSendDataReliable 
                                          error:nil];    
}

- (void)session:(GKSession *)session 
           peer:(NSString *)peerID 
 didChangeState:(GKPeerConnectionState)state {
    switch (state)
    {
        case GKPeerStateConnected:
            NSLog(@"connected");
            break;
        case GKPeerStateDisconnected:
            NSLog(@"disconnected");
            [self.currentSession release];
            currentSession = nil;
            
            [connect setHidden:NO];
            [disconnect setHidden:YES];
            break;
    }
}

-(IBAction) btnSend:(id) sender{
    NSData* data;
    NSString *str = [NSString stringWithString:txtMessage.text];
    data = [str dataUsingEncoding: NSASCIIStringEncoding];        
    [self mySendDataToPeers:data];        
}

- (void) receiveData:(NSData *)data 
            fromPeer:(NSString *)peer 
           inSession:(GKSession *)session 
             context:(void *)context {
	
		//---convert the NSData to NSString---
    NSString* str;
    str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data received" 
                                                    message:str 
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];    
}


-(IBAction) btnConnect:(id) sender{
	picker = [[GKPeerPickerController alloc] init];
    picker.delegate = self;
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;      
	
    [connect setHidden:YES];
    [disconnect setHidden:NO];    
    [picker show];    
}

-(IBAction) btnDisconnect:(id) sender {
    [self.currentSession disconnectFromAllPeers];
    [self.currentSession release];
    currentSession = nil;
    
    [connect setHidden:NO];
    [disconnect setHidden:YES];
}

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
	[currentSession release];
    [super dealloc];
}


@end
