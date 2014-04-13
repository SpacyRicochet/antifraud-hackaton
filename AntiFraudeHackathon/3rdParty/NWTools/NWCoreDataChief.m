//
//  NWCoreDataChief.m
//  NWTools
//
//  Created by Jorn on 14-02-12.
//  Copyright 2012 Noodlewerk All rights reserved.
//

#import "NWCoreDataChief.h"


@implementation NWCoreDataChief

@synthesize modelURL, storeURL, shouldLoadStoreInBundle;

- (id)initWithModelURL:(NSURL *)_modelURL storeURL:(NSURL *)_storeURL
{
    self = [super init];
    if (self) {
        modelURL = _modelURL;
        storeURL = _storeURL;
        shouldLoadStoreInBundle = YES;
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (!managedObjectContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil) {
            id context = [NSManagedObjectContext alloc];
            if ([context respondsToSelector:@selector(initWithConcurrencyType:)]) {
                managedObjectContext = [context initWithConcurrencyType:NSMainQueueConcurrencyType];
            } else {
                managedObjectContext = [context init];
            }
            [managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    NWAssert(self.modelURL != nil);
    if (!managedObjectModel) {
        managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return managedObjectModel;
}

- (NSPersistentStore *)addPersistentStore
{
    NSDictionary* optionsDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    NSError *error = nil;
    NSPersistentStore *newstore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:optionsDict error:&error];
    NWError(error);
    NWAssert(newstore != nil);
    return newstore;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!persistentStoreCoordinator) {
        
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        // Copy store from bundle
        if (shouldLoadStoreInBundle && storeURL) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if (![fileManager fileExistsAtPath:storeURL.path]) {
                NSString *storeBundlePath = [[NSBundle mainBundle] pathForResource:storeURL.lastPathComponent ofType:nil];
                if(storeBundlePath){
                    NSError *error = nil;
                    BOOL copied = [fileManager copyItemAtPath:storeBundlePath toPath:storeURL.path error:&error];
                    NWError(error);
                    NWAssert(copied);
                }
            }
        }
        
        if (storeURL) {
            NSPersistentStore *store = [self addPersistentStore];
            
            if (!store) {
                // Backup and create a new store
                NSString *backupSuffix = [NSString stringWithFormat:@"backup_%i", (int)[[NSDate date] timeIntervalSince1970]];
                NSURL *backupURL = [storeURL URLByAppendingPathExtension:backupSuffix];
                NSError *error = nil;
                [[NSFileManager defaultManager] moveItemAtURL:storeURL toURL:backupURL error:&error];
                NWError(error);
                NSPersistentStore *restore = [self addPersistentStore];
                NWAssert(restore != nil);
            }
        }
    }
    return persistentStoreCoordinator;
}

- (void)save
{
    NSError *error = nil;
    BOOL success = [self.managedObjectContext save:&error];
    NWError(error);
    NWAssert(success);
}

- (void)reset
{
    persistentStoreCoordinator = nil;
    managedObjectContext = nil;
    managedObjectModel = nil;
    if (storeURL) {
        NSError *error = nil;
        BOOL removed = [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
        NWError(error);
        NWAssert(removed);
    }
}

@end
