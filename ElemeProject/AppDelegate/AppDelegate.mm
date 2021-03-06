//
//  AppDelegate.m
//  ElemeProject
//
//  Created by Sam Lau on 6/7/15.
//  Copyright (c) 2015 Sam Lau. All rights reserved.
//

#import "ColorMacro.h"
#import "AppDelegate.h"
#import "WaiMaiViewController.h"
#import "OrderViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"
#import "UserPreferences.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    // increase launch image time
    sleep(1);

    // when first launch
    [self firstLaunch];

    // iniitalize and setup window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    self.window.rootViewController = [self rootViewController];

    // customize navigation bar
    [UINavigationBar appearance].barTintColor = THEME_COLOR;
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:20] };

    return YES;
}

- (void)applicationWillResignActive:(UIApplication*)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication*)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication*)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication*)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Helper methods
- (void)firstLaunch
{
    if ([UserPreferences isFirstLaunch]) {
        [UserPreferences enableAutoLocation];
        [UserPreferences disableFirstLaunch];
    }
}

- (UITabBarController*)rootViewController
{
    UITabBarController* tabBarController = [[UITabBarController alloc] init];

    WaiMaiViewController* waiMaiViewController = [[WaiMaiViewController alloc] init];
    OrderViewController* orderViewController = [[OrderViewController alloc] init];
    DiscoverViewController* discoverViewController = [[DiscoverViewController alloc] init];
    MeViewController* meViewController = [[MeViewController alloc] init];

    NSArray* subControllers = @[ waiMaiViewController, orderViewController, discoverViewController, meViewController ];
    NSMutableArray* tabSubControllers = [[NSMutableArray alloc] init];

    NSArray* titles = @[ @"外卖", @"饿单", @"发现", @"我的" ];
    NSArray* tabImageNames = @[ @"tab_shopping", @"tab_order", @"tab_discovery", @"tab_user" ];
    NSArray* tabSelectedImageNames = @[ @"tab_shopping_selected", @"tab_order_selected", @"tab_discovery_selected", @"tab_user_selected" ];

    [subControllers enumerateObjectsUsingBlock:^(UIViewController* controller, NSUInteger idx, BOOL* stop) {
        controller.tabBarItem.title = titles[idx];
        controller.tabBarItem.image = [UIImage imageNamed:tabImageNames[idx]];
        controller.tabBarItem.selectedImage = [UIImage imageNamed:tabSelectedImageNames[idx]];
        UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [tabSubControllers addObject:navigationController];
    }];
    tabBarController.viewControllers = tabSubControllers;

    return tabBarController;
}

@end
