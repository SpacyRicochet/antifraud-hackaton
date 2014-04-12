//
//  AFHActivity+Parse.h
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHActivity.h"

@class PFObject;

@interface AFHActivity (Parse)

+ (id)newWithParseObject:(PFObject *)object managedObjectContext:(NSManagedObjectContext *)context;

@end
