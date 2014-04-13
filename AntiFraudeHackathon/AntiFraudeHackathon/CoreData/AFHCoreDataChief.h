//
//  AFHCoreDataChief.h
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWCoreDataChief.h"

@interface AFHCoreDataChief : NWCoreDataChief

+ (AFHCoreDataChief *)shared;

#ifdef DEBUG_RESET_DATABASE
- (void)reset;
#endif

@end
