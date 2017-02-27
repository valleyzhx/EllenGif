//
//  AppDelegate.m
//  EllenGif
//
//  Created by Xiang on 16/8/31.
//  Copyright © 2016年 idreams.club. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApiManager.h"
#import "LaunchView.h"
#import <UMMobClick/MobClick.h>
#import <FirebaseAnalytics/FIRApp.h>
#import <JSPatchPlatform/JSPatch.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setDefualtConfigure];
    [WXApi registerApp:WXApi_ID withDescription:@"EllenGif"];
    UMAnalyticsConfig *config = [UMAnalyticsConfig sharedInstance];
    config.appKey = MobClick_ID;
    [MobClick startWithConfigure:config];
//    [FIRApp configure];
    
    [JSPatch startWithAppKey:@"7d5bb87d8626b8f3"];
    [JSPatch sync];
   

    [self.window makeKeyAndVisible];
    [[LaunchView defultVIew]showInView:KeyWindow];
    
    return YES;
}

-(void)setDefualtConfigure{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:kInitKeyword] == nil) {
        [[NSUserDefaults standardUserDefaults]setObject:@"熊本熊表情包" forKey:kInitKeyword];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
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
