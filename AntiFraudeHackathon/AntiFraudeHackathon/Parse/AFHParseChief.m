//
//  AFHParseChief.m
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHParseChief.h"
#import <Parse/Parse.h>
#import "AFHActivity.h"
#import "AFHActivity+Parse.h"

static NSString * const ParseDefaultsLastFetchDate = @"lastFetchDate";

static NSString * const ParseActivityClass = @"Activity";
static NSString * const ParseActivityCreation = @"createdAt";

static NSString * const ParseNotificationAlert = @"alert";

@implementation AFHParseChief

+ (AFHParseChief *)shared
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
    
    [currentInstallation addUniqueObject:@"Activities" forKey:@"channels"];
    
    [currentInstallation saveInBackground];
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo managedObjectContext:(NSManagedObjectContext *)context {
    
    NWLog(@"Received notification with payload:\n%@", userInfo);
}

#pragma mark - Fetching activities

- (void)fetchActivities
{
    [self fetchActivitiesSinceDate:[self dateSinceLastFetch]];
}

- (void)fetchActivitiesSinceDate:(NSDate *)date managedObjectContext:(NSManagedObjectContext *)context
{
    NWLog(@"Fetching activities since date: %@", date);
    
    PFQuery *query = [PFQuery queryWithClassName:ParseActivityClass];
    [query orderByDescending:ParseActivityCreation];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NWError(error);
            return;
        }
        
        for (__unsafe_unretained PFObject *object in objects) {
            NWLog(@"Found object: %@", object);
            
            [AFHActivity newWithParseObject:object managedObjectContext:context];
        }
        
        [self saveNowAsLastFetchDate];
    }];
}

#pragma mark - Last fetch date

- (NSDate *)dateSinceLastFetch
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastFetchDate = [userDefaults objectForKey:ParseDefaultsLastFetchDate];
    return lastFetchDate;
}

- (void)saveNowAsLastFetchDate
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:ParseDefaultsLastFetchDate];
    [userDefaults synchronize];
}

@end
