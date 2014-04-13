//
//  NWCoreDataChief.h
//  NWTools
//
//  Created by Jorn on 14-02-12.
//  Copyright 2012 Noodlewerk All rights reserved.
//

#import <CoreData/CoreData.h>


@interface NWCoreDataChief : NSObject {
	NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

//If the model doesn't already exist, it is created from the application's model.
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;

//If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

//If the coordinator doesn't already exist, it is created and the application's store added to it.
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong, readonly) NSURL *modelURL;
@property (nonatomic, strong, readonly) NSURL *storeURL;
@property (nonatomic) BOOL shouldLoadStoreInBundle;

- (id)initWithModelURL:(NSURL *)modelURL storeURL:(NSURL *)storeURL;
- (void)save;
- (void)reset;

@end
