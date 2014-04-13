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
#import "AFHParseConstants.h"

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

- (void)reset
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ParseDefaultsLastGetDate];
}

#pragma mark - Push notifications

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

#pragma mark - Get Activities

- (void)getActivitiesForManagedObjectContext:(NSManagedObjectContext *)context
{
    [self getActivitiesSinceDate:[self dateSinceLastGet] managedObjectContext:context];
}

- (void)getActivitiesSinceDate:(NSDate *)date managedObjectContext:(NSManagedObjectContext *)context
{
    NWLog(@"Fetching activities since date: %@", date);
    
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"createdAt > %@", date];
    PFQuery *query = [PFQuery queryWithClassName:ParseActivityClass predicate:datePredicate];
    [query orderByDescending:ParseActivityCreation];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NWError(error);
            return;
        }
        
        for (__unsafe_unretained PFObject *object in objects) {
            NWLog(@"Found object: %@", object);
            
            [AFHActivity createWithParseObject:object managedObjectContext:context];
        }
        
        [self saveNowAsLastGetDate];
    }];
}

#pragma mark - Last get date

- (NSDate *)dateSinceLastGet
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastFetchDate = [userDefaults objectForKey:ParseDefaultsLastGetDate];
    lastFetchDate = lastFetchDate ?: [NSDate dateWithTimeIntervalSince1970:0];
    return lastFetchDate;
}

- (void)saveNowAsLastGetDate
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:ParseDefaultsLastGetDate];
    [userDefaults synchronize];
}

@end
