//
//  AppDelegate.m
//  巴士驿站
//
//  Created by Edge on 16/7/10.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "AppDelegate.h"
#import "TLRootTabBarController.h"
#import "TLSettingViewController.h"
#import "LoginViewController.h"
#import<AMapFoundationKit/AMapFoundationKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController.tabBarItem.title isEqualToString:@"个人"]) {
            //跳到登录页面 CCPLoginVC
            LoginViewController *login = [[LoginViewController alloc]init];
            //隐藏tabbar
            login.hidesBottomBarWhenPushed =YES;
            [((UINavigationController *)tabBarController.selectedViewController)pushViewController:login animated:YES];
            return NO;
    }else {
    return YES;
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //  创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
   TLRootTabBarController *tabBarVc= [[TLRootTabBarController alloc]init];
    //self.window.backgroundColor = [UIColor yellowColor];
    self.window.rootViewController = tabBarVc;
    //  显示窗口
    tabBarVc.delegate=self;
    [self.window makeKeyAndVisible];
    
    [AMapServices sharedServices].apiKey = @"6920ea737d02e5c614bf6c25b237a93c";

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
