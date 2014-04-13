//
//  NWCoreData.m
//  NWTools
//
//  Created by Leo on 10/15/12.
//  Copyright (c) 2012 noodlewerk. All rights reserved.
//

#import "NWCoreData.h"


@implementation NWCoreData

+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    NWError(error);
    return result;
}

+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    request.predicate = [[NSComparisonPredicate alloc] initWithLeftExpression:[NSExpression expressionForKeyPath:keyPath] rightExpression:[NSExpression expressionForConstantValue:value] modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:0];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    NWError(error);
    return result;
}

+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value keyPath:(NSString *)keyPath2 value:(id)value2
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSPredicate *p1 = [[NSComparisonPredicate alloc] initWithLeftExpression:[NSExpression expressionForKeyPath:keyPath] rightExpression:[NSExpression expressionForConstantValue:value] modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:0];
    NSPredicate *p2 = [[NSComparisonPredicate alloc] initWithLeftExpression:[NSExpression expressionForKeyPath:keyPath2] rightExpression:[NSExpression expressionForConstantValue:value2] modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:0];
    request.predicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:@[p1, p2]];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    NWError(error);
    return result;
}

+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value operatorType:(NSPredicateOperatorType)operatorType
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSPredicate *p1 = [[NSComparisonPredicate alloc] initWithLeftExpression:[NSExpression expressionForKeyPath:keyPath] rightExpression:[NSExpression expressionForConstantValue:value] modifier:NSDirectPredicateModifier type:operatorType options:0];
    request.predicate = p1;
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    NWError(error);
    return result;
}

+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value operatorType:(NSPredicateOperatorType)operatorType1 keyPath:(NSString *)keyPath2 value:(id)value2 operatorType:(NSPredicateOperatorType)operatorType2
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSPredicate *p1 = [[NSComparisonPredicate alloc] initWithLeftExpression:[NSExpression expressionForKeyPath:keyPath] rightExpression:[NSExpression expressionForConstantValue:value] modifier:NSDirectPredicateModifier type:operatorType1 options:0];
    NSPredicate *p2 = [[NSComparisonPredicate alloc] initWithLeftExpression:[NSExpression expressionForKeyPath:keyPath2] rightExpression:[NSExpression expressionForConstantValue:value2] modifier:NSDirectPredicateModifier type:operatorType2 options:0];
    request.predicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:@[p1, p2]];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    NWError(error);
    return result;
}

+ (NSArray *)fetchObjectsFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName predicate:(NSString *)predicate
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    request.predicate = [NSPredicate predicateWithFormat:predicate];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    NWError(error);
    return result;
}

+ (id)fetchObjectFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value
{
    NSArray *results = [self fetchObjectsFromContext:context entityName:entityName keyPath:keyPath value:value];
    NWLogWarnIfNot(results.count < 2, @"Expecting single object of type %@ for key:value %@:%@", entityName, keyPath, value);
    return results.count ? results[0] : nil;
}

+ (id)fetchObjectFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value keyPath:(NSString *)keyPath2 value:(id)value2
{
    NSArray *results = [self fetchObjectsFromContext:context entityName:entityName keyPath:keyPath value:value keyPath:keyPath2 value:value2];
    NWLogWarnIfNot(results.count < 2, @"Expecting single object of type %@ for key:value %@:%@ and %@:%@", entityName, keyPath, value, keyPath2, value2);
    return results.count ? results[0] : nil;
}

+ (id)fetchObjectFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName predicate:(NSString *)predicate
{
    NSArray *results = [self fetchObjectsFromContext:context entityName:entityName predicate:predicate];
    NWLogWarnIfNot(results.count < 2, @"Expecting single object of type %@ for predicate %@", entityName, predicate);
    return results.count ? results[0] : nil;
}

+ (NSArray *)fetchPropertiesFromContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName propertyName:(NSString *)propertyName
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    if (propertyName.length) request.propertiesToFetch = @[propertyName];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    NWError(error);
    NSArray *result = [results valueForKey:propertyName];
    return result;
}

@end


@implementation NSManagedObjectContext (NWCoreData)

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName
{
    return [NWCoreData fetchObjectsFromContext:self entityName:entityName];
}

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value
{
    return [NWCoreData fetchObjectsFromContext:self entityName:entityName keyPath:keyPath value:value];
}

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value keyPath:(NSString *)keyPath2 value:(id)value2
{
    return [NWCoreData fetchObjectsFromContext:self entityName:entityName keyPath:keyPath value:value keyPath:keyPath2 value:value2];
}

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value operatorType:(NSPredicateOperatorType)operatorType1 keyPath:(NSString *)keyPath2 value:(id)value2 operatorType:(NSPredicateOperatorType)operatorType2
{
    return [NWCoreData fetchObjectsFromContext:self entityName:entityName keyPath:keyPath value:value operatorType:operatorType1 keyPath:keyPath2 value:value2 operatorType:operatorType2];
}

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value operatorType:(NSPredicateOperatorType)operatorType
{
    return [NWCoreData fetchObjectsFromContext:self entityName:entityName keyPath:keyPath value:value operatorType:operatorType];
}

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName predicate:(NSString *)predicate
{
    return [NWCoreData fetchObjectsFromContext:self entityName:entityName predicate:predicate];
}

- (id)fetchObjectWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value
{
    return [NWCoreData fetchObjectFromContext:self entityName:entityName keyPath:keyPath value:value];
}

- (id)fetchObjectWithEntityName:(NSString *)entityName keyPath:(NSString *)keyPath value:(id)value keyPath:(NSString *)keyPath2 value:(id)value2
{
    return [NWCoreData fetchObjectFromContext:self entityName:entityName keyPath:keyPath value:value keyPath:keyPath2 value:value2];
}

- (id)fetchObjectWithEntityName:(NSString *)entityName predicate:(NSString *)predicate
{
    return [NWCoreData fetchObjectFromContext:self entityName:entityName predicate:predicate];
}

- (NSArray *)fetchPropertiesWithEntityName:(NSString *)entityName propertyName:(NSString *)propertyName
{
    return [NWCoreData fetchPropertiesFromContext:self entityName:entityName propertyName:propertyName];
}

@end
