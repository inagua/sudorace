//
//  sudoraceAppDelegate.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sudoraceAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UINavigationController *navController;
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;

@end

