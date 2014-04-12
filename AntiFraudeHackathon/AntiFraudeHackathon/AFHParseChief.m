//
//  AFHParseChief.m
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHParseChief.h"
#import <Parse/Parse.h>

@implementation AFHParseChief

+ (instancetype)shared
{
    static AFHParseChief *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [AFHParseChief new];
        [result setupParse];
    });
    return result;
}

- (void)setupParse
{
    [Parse setApplicationId:@"X5OVmxuKqQDZ43ibTIwdTmrJN15RTEzjbFAP74yJ"
                  clientKey:@"DIjgsffDEdAiJK0HkTDN9C0XmTresMNknfVFiW5b"];
    
    UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
}

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  [currentInstallation setDeviceTokenFromData:deviceToken];
  [currentInstallation saveInBackground];
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

@end
