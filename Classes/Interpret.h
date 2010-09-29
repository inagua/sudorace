//
//  Interpret.h
//  sudorace
//
//  Created by Stéphane Tavera on 9/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface Interpret : NSObject {

}

+(Interpret *)shared;

-(Command *)read:(NSString *)message;

@end
