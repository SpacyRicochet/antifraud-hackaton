//
//  AFHResponseParser.m
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHAditionalDataHelper.h"

@implementation AFHAditionalDataHelper

static NSDictionary *mainDict;

+ (NSDictionary *)jsonDictFromFile
{
    if(!mainDict)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mockedData" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        mainDict = json;
    }
    return mainDict;
}

+ (NSDictionary *)dictForKey:(NSString *)key
{
    NSDictionary *mainDict = [self jsonDictFromFile];
    NSDictionary *result = [mainDict objectForKey:key];
    return result;
}

@end
