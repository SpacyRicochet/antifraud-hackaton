//
//  AFHActivity+Parse.m
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHActivity+Parse.h"
#import <Parse/Parse.h>
#import "AFHParseConstants.h"

@implementation AFHActivity (Parse)

+ (id)newWithParseObject:(PFObject *)object managedObjectContext:(NSManagedObjectContext *)context
{
    NWLogWarnIfNot(context, @"No managed object context to create object in.");
    
    if (![[object parseClassName] isEqualToString:ParseActivityClass]) {
        NWLogWarn(@"Parse object is not of class %@. Class name: %@", ParseActivityClass, object.parseClassName);
        return nil;
    }
    
    AFHActivity *result = [AFHActivity insertInManagedObjectContext:context];
    result.identifier       = object.objectId;
    result.date             = object.createdAt;
    result.city             = object[ParseActivityCity];
    result.event            = object[ParseActivityEvent];
    result.flagged          = object[ParseActivityFlagged];
    result.institution      = object[ParseActivityInstitution];
    result.source           = object[ParseActivitySource];
    
    PFGeoPoint *geoPoint    = object[ParseActivityLocation];
    result.latitudeValue    = geoPoint.latitude;
    result.longitudeValue   = geoPoint.longitude;
    
    return result;
}

@end
