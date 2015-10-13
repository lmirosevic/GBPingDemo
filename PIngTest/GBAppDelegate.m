//
//  GBAppDelegate.m
//  PingDemo
//
//  Created by Luka Mirosevic on 15/11/2012.
//  Copyright (c) 2012 Goonbee. All rights reserved.
//

#import "GBAppDelegate.h"

@implementation GBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // create and configure a new ping object
    self.ping = [GBPing new];
    self.ping.host = @"google.com";
//    self.ping.host = @"192.168.0.140";
//    self.ping.host = @"192.168.0.255";
    self.ping.delegate = self;
    self.ping.timeout = 1;
    self.ping.pingPeriod = 0.9;
    
    // setup the ping object (this resolves addresses etc)
    [self.ping setupWithBlock:^(BOOL success, NSError *error) {
        if (success) {
            // start pinging
            [self.ping startPinging];
            
            // stop it after 5 seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"stop it");
                [self.ping stop];
                self.ping = nil;
            });
        } else {
            NSLog(@"failed to start");
        }
    }];

    
    
    
    //iOS boilerplate, we don't need any UI so we just show an empty UIViewController
    self.window = [UIWindow new];
    self.window.rootViewController = [UIViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)ping:(GBPing *)pinger didReceiveReplyWithSummary:(GBPingSummary *)summary {
    NSLog(@"REPLY>  %@", summary);
}

-(void)ping:(GBPing *)pinger didReceiveUnexpectedReplyWithSummary:(GBPingSummary *)summary {
    NSLog(@"BREPLY> %@", summary);
}

-(void)ping:(GBPing *)pinger didSendPingWithSummary:(GBPingSummary *)summary {
    NSLog(@"SENT>   %@", summary);
}

-(void)ping:(GBPing *)pinger didTimeoutWithSummary:(GBPingSummary *)summary {
    NSLog(@"TIMOUT> %@", summary);
}

-(void)ping:(GBPing *)pinger didFailWithError:(NSError *)error {
    NSLog(@"FAIL>   %@", error);
}

-(void)ping:(GBPing *)pinger didFailToSendPingWithSummary:(GBPingSummary *)summary error:(NSError *)error {
    NSLog(@"FSENT>  %@, %@", summary, error);
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

@end

