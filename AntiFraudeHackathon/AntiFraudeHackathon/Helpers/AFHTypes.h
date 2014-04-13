//
//  AFHTypes.h
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, AFHFraudeType)
{
    kAFHFraudeTypeAdresAangepast,
    kAFHFraudeTypeOverleden,
    kAFHFraudeTypeSubsidieAangepast,
    kAFHFraudeTypeRekeningAangepast,
    kAFHFraudeTypeIDVermistOpgegeven,
    kAFHFraudeTypeIDAangevraagd,
    kAFHFraudeTypeKredietAanvraag,
    kAFHFraudeTypeBedrijfOpgericht,
    kAFHFraudeTypeBuitenlandInschrijven,
    kAFHFraudeTypeAangifteInbraak,
    kAFHFraudeTypeDigiDLogin
};

//typedef NS_ENUM(NSUInteger, AFHInstantieType)
//{
//    kAFHInstantieTypeOverheid,
//    kAFHInstantieTypeDNB,
//    kAFHInstantieTypePolitie,
//    kAFHInstantieTypeRPS,
//    kAFHInstantieTypeBKR,
//    kAFHInstantieTypeKVK,
//    kAFHInstantieTypeComputer
//};

typedef NS_ENUM(NSUInteger, AFHDatabaseType)
{
    kAFHDatabaseTypeGBA,
    kAFHDatabaseTypeRNI,
    kAFHDatabaseTypeBSN,
    kAFHDatabaseTypeBR,
    kAFHDatabaseTypeVR,
    kAFHDatabaseTypePIVA,
    kAFHDatabaseTypeBAG,
    kAFHDatabaseTypeEPD
};

typedef NS_ENUM(NSUInteger, AFHStappenType)
{
    kAFHStappenTypeControle,
    kAFHStappenTypeMelding,
    kAFHStappenTypeExtra
};