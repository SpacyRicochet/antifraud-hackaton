//
//  AFHResponseParser.h
//  AntiFraudeHackathon
//
//  Created by Michiel Boertjes on 13/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSDictionary (AFH)

- (CLLocationCoordinate2D)locationForStep:(NSNumber *)step;
- (NSURL *)urlForStep:(NSNumber *)step;
- (NSString *)textForStep:(NSNumber *)step;
- (NSString *)information;
- (UIImage *)image;

@end

@interface AFHAdditionalDataHelper : NSObject

+ (NSDictionary *)dictForKey:(NSString *)key;

@end
