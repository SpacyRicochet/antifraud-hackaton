//
//  NWCoreData.h
//  NWTools
//
//  Created by Leo on 10/15/12.
//  Copyright (c) 2012 noodlewerk. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface NWCoreData : NSObject

+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName;
+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value;
+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value keyPath:(NSString *)keyPath value:(id)value;
+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName predicate:(NSString *)predicate;

+ (id)fetchObjectFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value;
+ (id)fetchObjectFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value keyPath:(NSString *)keyPath value:(id)value;
+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value operatorType:(NSPredicateOperatorType)operatorType;
+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value operatorType:(NSPredicateOperatorType)operatorType1 keyPath:(NSString *)keyPath2 value:(id)value2 operatorType:(NSPredicateOperatorType)operatorType2;
+ (id)fetchObjectFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName predicate:(NSString *)predicate;

+ (NSArray *)fetchPropertiesFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName propertyName:(NSString *)propertyName;

@end


@interface NSManagedObjectContext (NWCoreData)

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName;
- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value;
- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value keyPath:(NSString *)keyPath value:(id)value;
- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value operatorType:(NSPredicateOperatorType)operatorType;
- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value operatorType:(NSPredicateOperatorType)operatorType1 keyPath:(NSString *)keyPath2 value:(id)value2 operatorType:(NSPredicateOperatorType)operatorType2;
- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName predicate:(NSString *)predicate;

- (id)fetchObjectWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value;
- (id)fetchObjectWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value keyPath:(NSString *)keyPath value:(id)value;
- (id)fetchObjectWithEntityName:(NSString *)entityName predicate:(NSString *)predicate;

- (NSArray *)fetchPropertiesWithEntityName:(NSString *)entityName propertyName:(NSString *)propertyName;

@end
