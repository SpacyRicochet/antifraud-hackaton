//
//  AFHDataObject.h
//  AntiFraudeHackathon
//
//  Created by Jonas Treub on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFHDataObject : NSObject

@property (nonatomic, retain) NSString *identifier; // unique reference to database
@property (nonatomic, retain) NSString *description; // description
@property (nonatomic, retain) NSString *accessor; // authority
@property (nonatomic, retain) NSDate *timeStamp; // modification date
@property (nonatomic, retain) NSValue *location; // geographical location
@property (nonatomic, readwrite) BOOL flagged; // marked by user

@end
