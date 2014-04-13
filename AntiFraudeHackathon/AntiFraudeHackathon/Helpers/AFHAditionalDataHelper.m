//
//  AFHResponseParser.m
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHAditionalDataHelper.h"

@implementation NSDictionary (AFH)

- (CLLocationCoordinate2D)locationForStep:(NSNumber *)step
{
    NSString *keyLat = [@"lat" stringByAppendingString:step.stringValue];
    NSString *keyLong = [@"long" stringByAppendingString:step.stringValue];
    NSString *stringLat = [self objectForKey:keyLat];
    NSString *stringLong = [self objectForKey:keyLong];
    
    CLLocationCoordinate2D result = CLLocationCoordinate2DMake(stringLat.floatValue, stringLong.floatValue);
    return result;
}

- (NSURL *)urlForStep:(NSNumber *)step
{
    NSString *key = [@"url" stringByAppendingString:step.stringValue];
    NSString *urlString = [self objectForKey:key];
    NSURL *result = [NSURL URLWithString:urlString];
    return result;
}

- (NSString *)information
{
    NSString *result = [self objectForKey:@"informatie"];
    return result;
}

- (UIImage *)image
{
    NSString *imageName = [self objectForKey:@"image"];
    UIImage *result = [UIImage imageNamed:imageName];
    return result;
}

- (NSString *)textForStep:(NSNumber *)step
{
    NSString *key = [@"maatregel" stringByAppendingString:step.stringValue];
    NSString *result = [self objectForKey:key];
    return result;
}

@end

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
