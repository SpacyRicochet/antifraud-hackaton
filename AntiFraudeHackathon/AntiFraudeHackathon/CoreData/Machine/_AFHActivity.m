// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AFHActivity.m instead.

#import "_AFHActivity.h"

const struct AFHActivityAttributes AFHActivityAttributes = {
	.accessor = @"accessor",
	.city = @"city",
	.database = @"database",
	.date = @"date",
	.event = @"event",
	.flagged = @"flagged",
	.identifier = @"identifier",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.placeholder0 = @"placeholder0",
	.placeholder1 = @"placeholder1",
	.placeholder2 = @"placeholder2",
};

const struct AFHActivityRelationships AFHActivityRelationships = {
};

const struct AFHActivityFetchedProperties AFHActivityFetchedProperties = {
};

@implementation AFHActivityID
@end

@implementation _AFHActivity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Activity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Activity" inManagedObjectContext:moc_];
}

- (AFHActivityID*)objectID {
	return (AFHActivityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"flaggedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"flagged"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic accessor;






@dynamic city;






@dynamic database;






@dynamic date;






@dynamic event;






@dynamic flagged;



- (BOOL)flaggedValue {
	NSNumber *result = [self flagged];
	return [result boolValue];
}

- (void)setFlaggedValue:(BOOL)value_ {
	[self setFlagged:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFlaggedValue {
	NSNumber *result = [self primitiveFlagged];
	return [result boolValue];
}

- (void)setPrimitiveFlaggedValue:(BOOL)value_ {
	[self setPrimitiveFlagged:[NSNumber numberWithBool:value_]];
}





@dynamic identifier;






@dynamic latitude;



- (float)latitudeValue {
	NSNumber *result = [self latitude];
	return [result floatValue];
}

- (void)setLatitudeValue:(float)value_ {
	[self setLatitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result floatValue];
}

- (void)setPrimitiveLatitudeValue:(float)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithFloat:value_]];
}





@dynamic longitude;



- (float)longitudeValue {
	NSNumber *result = [self longitude];
	return [result floatValue];
}

- (void)setLongitudeValue:(float)value_ {
	[self setLongitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result floatValue];
}

- (void)setPrimitiveLongitudeValue:(float)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithFloat:value_]];
}





@dynamic placeholder0;






@dynamic placeholder1;






@dynamic placeholder2;











@end
