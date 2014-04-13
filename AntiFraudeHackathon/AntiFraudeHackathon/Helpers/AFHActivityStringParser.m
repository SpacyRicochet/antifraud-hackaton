//
//  AFHResponseParser.m
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHActivityStringParser.h"

@implementation AFHActivityStringParser

+ (AFHFraudeType)fraudeTypeFromEventString:(NSString *)event
{
    return kAFHFraudeTypeAangifteInbraak;
}

+ (AFHInstantieType)instantieTypeFromAccessorString:(NSString *)accessor
{
    return kAFHInstantieTypeComputer;
}

+ (NSArray *)databasesFromDatabaseString:(NSString *)databaseString
{
    NSArray *databaseStrings = [databaseString componentsSeparatedByString:@","];
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *databaseString in databaseStrings) {
        if([databaseString isEqualToString:@"GBA"])
        {
            NSNumber *type = [NSNumber numberWithInteger:kAFHDatabaseTypeGBA];
            [result addObject:type];
            continue;
        }
        if([databaseString isEqualToString:@"RNI"])
        {
            NSNumber *type = [NSNumber numberWithInteger:kAFHDatabaseTypeRNI];
            [result addObject:type];
            continue;
        }
        if([databaseString isEqualToString:@"BSN"])
        {
            NSNumber *type = [NSNumber numberWithInteger:kAFHDatabaseTypeBSN];
            [result addObject:type];
            continue;
        }
        if([databaseString isEqualToString:@"BR"])
        {
            NSNumber *type = [NSNumber numberWithInteger:kAFHDatabaseTypeBR];
            [result addObject:type];
            continue;
        }
        if([databaseString isEqualToString:@"VR"])
        {
            NSNumber *type = [NSNumber numberWithInteger:kAFHDatabaseTypeVR];
            [result addObject:type];
            continue;
        }
        if([databaseString isEqualToString:@"PIVA"])
        {
            NSNumber *type = [NSNumber numberWithInteger:kAFHDatabaseTypePIVA];
            [result addObject:type];
            continue;
        }
        if([databaseString isEqualToString:@"BAG"])
        {
            NSNumber *type = [NSNumber numberWithInteger:kAFHDatabaseTypeBAG];
            [result addObject:type];
            continue;
        }
        if([databaseString isEqualToString:@"EPD"])
        {
            NSNumber *type = [NSNumber numberWithInteger:kAFHDatabaseTypeEPD];
            [result addObject:type];
            continue;
        }
    }
    return result;
}

+ (NSArray *)stappenForInstantie:(AFHInstantieType)instantieType
{
    NSMutableArray *result = [NSMutableArray array];
    NSNumber *type = [NSNumber numberWithInteger:kAFHStappenTypeControle];
    [result addObject:type];
    switch (instantieType) {
        case kAFHInstantieTypeBKR:
        case kAFHInstantieTypeComputer:
        case kAFHInstantieTypeDNB:
        case kAFHInstantieTypeKVK:
        case kAFHInstantieTypeOverheid:
        case kAFHInstantieTypePolitie:
        case kAFHInstantieTypeRPS:
        default:
            break;
    }
    return result;
}

@end
