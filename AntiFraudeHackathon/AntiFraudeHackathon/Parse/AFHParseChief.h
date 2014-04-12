//
//  AFHParseChief.h
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFHParseChief : NSObject

+ (AFHParseChief *)shared;

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo managedObjectContext:(NSManagedObjectContext *)context;
- (void)fetchActivities;
- (void)fetchActivitiesSinceDate:(NSDate *)date;


@end
