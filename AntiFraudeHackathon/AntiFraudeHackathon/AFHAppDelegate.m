//
//  AFHAppDelegate.m
//  AntiFraudeHackathon
//
//  Created by Bruno Scheele on 12/04/14.
//  Copyright (c) 2014 V.o.f. Noodlewerk Apps. All rights reserved.
//

#import "AFHAppDelegate.h"
#import "AFHParseChief.h"
#import "AFHCoreDataChief.h"
#import <CoreData/CoreData.h>

@interface AFHAppDelegate ()

@property (nonatomic, strong) AFHParseChief *parseChief;
@property (nonatomic, strong) AFHCoreDataChief *coreDataChief;

@end

@implementation AFHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Override point for customization after application launch.
    
    // Setup chiefs
    self.parseChief = [AFHParseChief shared];
    self.coreDataChief = [AFHCoreDataChief shared];
    
#ifdef DEBUG_RESET_DATABASE
    [self.coreDataChief reset];
    [self.parseChief reset];
#endif
    
    [self.parseChief getActivitiesForManagedObjectContext:self.coreDataChief.managedObjectContext];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self.parseChief didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self.parseChief didReceiveRemoteNotification:userInfo managedObjectContext:self.coreDataChief.managedObjectContext];
}

@end
