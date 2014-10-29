//
//  AppDelegate.m
//  scrollviewTest
//
//  Created by Ray Migneco on 10/24/14.
//  Copyright (c) 2014 Urban Outfitters. All rights reserved.
//

#import "AppDelegate.h"
#import "UOTabScrollViewController.h"
#import "UOHeaderScrollViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    UOTabScrollViewController *vc2 = [[UOTabScrollViewController alloc] init];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"No Header" image:[UIImage new] tag:0];
    
    UOHeaderScrollViewController *vc1 = [[UOHeaderScrollViewController alloc] init];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Header" image:[UIImage new] tag:1];
    UITabBarController *tc = [[UITabBarController alloc] init];
    
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];

    tc.viewControllers = [NSArray arrayWithObjects:nav2, nav1, nil];
    self.rootViewController = tc;
//    self.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    
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

@end
