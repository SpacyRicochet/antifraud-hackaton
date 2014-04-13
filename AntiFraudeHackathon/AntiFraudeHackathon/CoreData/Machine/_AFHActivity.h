// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AFHActivity.h instead.

#import <CoreData/CoreData.h>


extern const struct AFHActivityAttributes {
	__unsafe_unretained NSString *accessor;
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *database;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *event;
	__unsafe_unretained NSString *flagged;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *placeholder0;
	__unsafe_unretained NSString *placeholder1;
	__unsafe_unretained NSString *placeholder2;
} AFHActivityAttributes;

extern const struct AFHActivityRelationships {
} AFHActivityRelationships;

extern const struct AFHActivityFetchedProperties {
} AFHActivityFetchedProperties;











@class NSObject;
@class NSObject;
@class NSObject;

@interface AFHActivityID : NSManagedObjectID {}
@end

@interface _AFHActivity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AFHActivityID*)objectID;





@property (nonatomic, strong) NSString* accessor;



//- (BOOL)validateAccessor:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* city;



//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* database;



//- (BOOL)validateDatabase:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* date;



//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* event;



//- (BOOL)validateEvent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* flagged;



@property BOOL flaggedValue;
- (BOOL)flaggedValue;
- (void)setFlaggedValue:(BOOL)value_;

//- (BOOL)validateFlagged:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* identifier;



//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* latitude;



@property float latitudeValue;
- (float)latitudeValue;
- (void)setLatitudeValue:(float)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* longitude;



@property float longitudeValue;
- (float)longitudeValue;
- (void)setLongitudeValue:(float)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) id placeholder0;



//- (BOOL)validatePlaceholder0:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) id placeholder1;



//- (BOOL)validatePlaceholder1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) id placeholder2;



//- (BOOL)validatePlaceholder2:(id*)value_ error:(NSError**)error_;






@end

@interface _AFHActivity (CoreDataGeneratedAccessors)

@end

@interface _AFHActivity (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAccessor;
- (void)setPrimitiveAccessor:(NSString*)value;




- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveDatabase;
- (void)setPrimitiveDatabase:(NSString*)value;




- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSString*)primitiveEvent;
- (void)setPrimitiveEvent:(NSString*)value;




- (NSNumber*)primitiveFlagged;
- (void)setPrimitiveFlagged:(NSNumber*)value;

- (BOOL)primitiveFlaggedValue;
- (void)setPrimitiveFlaggedValue:(BOOL)value_;




- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (float)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(float)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (float)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(float)value_;




- (id)primitivePlaceholder0;
- (void)setPrimitivePlaceholder0:(id)value;




- (id)primitivePlaceholder1;
- (void)setPrimitivePlaceholder1:(id)value;




- (id)primitivePlaceholder2;
- (void)setPrimitivePlaceholder2:(id)value;




@end
