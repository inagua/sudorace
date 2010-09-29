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
#import "SessionKeeper.h"
#import "SwitchViewController.h"
#import "Command.h"
#import "Interpret.h"

@interface DashboardViewController(private)
-(NSString *)fullName:(NSString *)peerID;
-(void) updateListPeers;
-(void) addAccessArenaButtonForArena:(Arena *)arena;
-(void) announcePeersArenaCreated:(Arena *)arena;
@end

@implementation DashboardViewController

@synthesize currentSession;
@synthesize namesAround;
@synthesize arenasView;
@synthesize switcher;
@synthesize arenasToJoinButtons;

-(IBAction) createArena {
		
	NSString *myName = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];	
	Player *me = [[Player alloc] initWithName:myName];	
	Arena *arena = [[Arena alloc] initWithPlayer:me];

	[self addAccessArenaButtonForArena:arena];
	[self announcePeersArenaCreated:arena];	
}

-(void) announcePeersArenaCreated:(Arena *)arena {
	
	NSLog(@"SUDORACE will try to announcePeersArenaCreated");
	
	NSString *myPeerId = currentSession.peerID;
	NSString *newArenaMessage	= [NSString stringWithFormat:@"newarena:%@", myPeerId];
	NSData *data		= [newArenaMessage dataUsingEncoding: NSASCIIStringEncoding];
	
    if (currentSession) {		
		NSLog(@"SUDORACE announcePeersArenaCreated %@", data);		
        BOOL sent = [currentSession sendDataToAllPeers:data 
							  withDataMode:GKSendDataReliable 
									 error:nil];   
		NSLog(@"sent %d", sent);
	}	
}

-(void) addAccessArenaButtonForArena:(Arena *)arena {
	
	UIButton *buttonAccess = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	NSString *title = [NSString stringWithFormat:@"Arena created by %@", arena.originalGrid.player.name];	
	[buttonAccess setTitle:title forState:UIControlStateNormal];	
	buttonAccess.frame = CGRectMake(5.0, 5.0, 200.0, 40.0);	
	
	[arenasView addSubview:buttonAccess];
}


-(void)accessArena {
	
	//	Grid *grid = [[arena gridsOrderedByFilling] objectAtIndex:0];
	
	//	ArenaViewController *arenaController = [[ArenaViewController alloc] initWithNibName:@"ArenaViewController" bundle:nil];
	//	arenaController.arena = arena;	
	//	arenaController.grid = grid;		
	//	[self.navigationController pushViewController:arenaController animated:YES];
	//	[arenaController release];
}


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
//    }
//    return self;
//}


-(IBAction) showArena{
	NSString *myName = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];	
	Player *me = [[Player alloc] initWithName:myName];	
	Arena *arena = [[Arena alloc] initWithPlayer:me];
	Grid *grid = [arena.grids objectAtIndex:0];
	
	ArenaViewController *arenaController = [[ArenaViewController alloc] init];
	arenaController.arena = arena;
	arenaController.grid  = grid;
	
	[switcher.navigationController pushViewController:arenaController animated:YES];
	
	[arenaController release];	
}

-(IBAction) toggleInfo{
	[switcher toggleInfo];
}

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
		
	NSLog(@"SUDORACE will try to send my name");
	
	NSString *myName	= [NSString stringWithFormat:@"name:%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"name"]];	
	NSData *data		= [myName dataUsingEncoding: NSASCIIStringEncoding];
	
    if (currentSession) {		
		NSLog(@"SUDORACE sending %@", data);		
        BOOL sent = [currentSession sendDataToAllPeers:data 
										  withDataMode:GKSendDataReliable 
												 error:nil];   
		NSLog(@"SUDORACE sent %d", sent);
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
		[listNames addObject:[currentSession displayNameForPeer:peerID]];
	}	
	self.namesAround.text = [listNames componentsJoinedByString:@", "];		
	NSLog(@"SUDORACE updating with %@", listNames);
	
	[self sendMyNameToPeers];
}

-(void)addArenaToJoin:(NSString *) arenaId{
	UIButton *buttonJoin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	NSString *title = [NSString stringWithFormat:@"Join arena %@", arenaId];	
	[buttonJoin setTitle:title forState:UIControlStateNormal];	
	buttonJoin.frame = CGRectMake(5.0, 5.0, 200.0, 40.0);	
	
	[arenasView addSubview:buttonJoin];	
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
	NSLog(@"SUDORACE receiving");	
    NSString *str	= [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];			
	Command *cmd	= [[Interpret shared] read:str];	
	
	NSString *verb = cmd.verb;
	NSString *params = cmd.params;
	NSLog(@"SUDORACE receiving %@ %@", verb, params);	
	
	if ([verb isEqualToString:@"newarena"]) {
		[self addArenaToJoin:params];
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];    
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewDidLoad {
	self.currentSession = [SessionKeeper shared].currentSession;
	self.currentSession.delegate = self;
	[self.currentSession setDataReceiveHandler:self withContext:nil];	
	NSLog(@"current session = %@", self.currentSession);
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[currentSession release];
	[namesAround release];
	[arenasView release];
	[arenasToJoinButtons release];
	[switcher release];
	
    [super dealloc];
}


@end
