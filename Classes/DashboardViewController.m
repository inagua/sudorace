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

@interface DashboardViewController(private)
-(NSString *)fullName:(NSString *)peerID;
-(void) updateListPeers;
@end


@implementation DashboardViewController

@synthesize currentSession;
@synthesize namesAround;

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

- (void)session:(GKSession*) session didReceiveConnectionRequestFromPeer:(NSString*) peerID {
	NSLog(@"SUDORACE will accept connection from %@", [self fullName:peerID]);
    [session acceptConnectionFromPeer:peerID error:nil];
}


- (void) sendMyNameToPeers{
	
	NSString *myName	= [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];	
	NSData *data		= [myName dataUsingEncoding: NSASCIIStringEncoding];
	
    if (currentSession) {		
		NSLog(@"SUDORACE sending %@", data);		
        [currentSession sendDataToAllPeers:data 
							  withDataMode:GKSendDataReliable 
									 error:nil];    
	}
}

-(NSString *)fullName:(NSString *)peerID{
	return [NSString stringWithFormat:@"%@(%@)", peerID, [currentSession displayNameForPeer:peerID]];
}

-(NSString *)display:(GKPeerConnectionState)state{
	NSString *stateS = @"GKState unknown ?";
	switch (state) {
		case GKPeerStateAvailable:
			stateS= @"GKPeerStateAvailable";
			break;
		case GKPeerStateUnavailable:
			stateS= @"GKPeerStateUnavailable";
			break;
		case GKPeerStateConnected:
			stateS= @"GKPeerStateConnected";
			break;
		case GKPeerStateDisconnected:
			stateS= @"GKPeerStateDisconnected";
			break;
		case GKPeerStateConnecting:
			stateS= @"GKPeerStateConnecting";
			break;
	}
	return stateS;
}

- (void)session:(GKSession *)session 
		   peer:(NSString *)peerID 
 didChangeState:(GKPeerConnectionState)state {
	
	NSString *stateS = [self display:state];	
	NSLog(@"SUDORACE state changed for %@, is now %@", [self fullName:peerID], stateS);
	
	// Retain new session.
	self.currentSession = session;
	
	switch (state) {
		case GKPeerStateAvailable:
			NSLog(@"SUDORACE will try to connect with %@", [self fullName:peerID]);
			[session connectToPeer:peerID withTimeout:0];
			break;
			
		case GKPeerStateConnected:
			NSLog(@"");
			NSString *peerFullName = [self fullName:peerID];
			NSLog(@"SUDORACE connected with %@", peerFullName);			
			[self updateListPeers];
			break;
			
		case GKPeerStateDisconnected:
			NSLog(@"SUDORACE disconnected with %@", [self fullName:peerID]);
			[self updateListPeers];
			break;
			
		default:
			NSLog(@"SUDORACE no action for ", stateS);	
	}
	
}

-(void) updateListPeers{	
	
	NSMutableArray *listNames = [NSMutableArray array];	
	for (NSString *peerID in [currentSession peersWithConnectionState:GKPeerStateConnected]) {
		[listNames addObject:[self fullName:peerID]];
	}	
	self.namesAround.text = [listNames componentsJoinedByString:@", "];		
	NSLog(@"SUDORACE updating with %@", listNames);
	
	[self sendMyNameToPeers];
}

- (void) receiveData:(NSData *)data 
            fromPeer:(NSString *)peer 
           inSession:(GKSession *)session 
             context:(void *)context {
	
    NSString* str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];    	
	NSLog(@"SUDORACE receiving %@", str);	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewDidLoad {
		
	self.currentSession = [[GKSession alloc] initWithSessionID:nil displayName:nil sessionMode:GKSessionModePeer];
	self.currentSession.delegate = self;
	self.currentSession.available = YES;
	self.currentSession.disconnectTimeout = 0;		
	[self.currentSession setDataReceiveHandler:self withContext:nil];

}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[currentSession release];
	[namesAround release];
	
    [super dealloc];
}


@end
