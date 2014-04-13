//
//  AFHCoreDataChief.m
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHCoreDataChief.h"
#import "NWCoreData.h"
#import "AFHActivity.h"

@implementation AFHCoreDataChief

+ (AFHCoreDataChief *)shared
{
    static AFHCoreDataChief *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AntiFraude" withExtension:@"momd"];
        NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"AntiFraude.sqlite"];

        result = [[AFHCoreDataChief alloc] initWithModelURL:modelURL storeURL:storeURL];
        
#ifdef DEBUG_RESET_DATABASE
        [result resetDatabase];
#endif
    });
    return result;
}

#pragma mark - Helper methods

- (void)setupDatabase
{
    if ([self isPopulated]) {
        NWLogInfo(@"Already populated. Skip adding demo data.");
        return;
    }
}

- (void)resetDatabase
{
    NSArray *fetchedObjects = [NWCoreData fetchObjectsFromContext:self.managedObjectContext entityName:[AFHActivity entityName]];
    for (__unsafe_unretained NSManagedObject *toBeDeleted in fetchedObjects) {
        [self.managedObjectContext deleteObject:toBeDeleted];
    }
    [self save];
}

- (BOOL)isPopulated
{
    NSArray *fetchedObjects = [NWCoreData fetchObjectsFromContext:self.managedObjectContext entityName:[AFHActivity entityName]];
    return fetchedObjects.count > 0;
}

@end
